//
//  MTPopupWindow.m
//  PopupWindowProject
//
//  Created by Marin Todorov on 7/1/11.
//  Copyright 2011 Marin Todorov. MIT license
//  http://www.opensource.org/licenses/mit-license.php
//

#import "MTPopupWindow.h"
#import "AppDelegate.h"

#define kShadeViewTag 1000

@interface MTPopupWindow(Private)
- (id)initWithSuperview:(UIView*)sview andFile:(NSString*)fName;
@end

@implementation MTPopupWindow

/**
 * This is the only public method, it opens a popup window and loads the given content
 * @param NSString* fileName provide a file name to load a file from the app resources, or a URL to load a web page
 * @param UIView* view provide a UIViewController's view here (or other view)
 */
+(void)showWindowWithHTMLFile:(NSString*)fileName insideView:(UIView*)view
{
    [[MTPopupWindow alloc] initWithSuperview:view andFile:fileName] ; 
}

/**
 * Initializes the class instance, gets a view where the window will pop up in
 * and a file name/ URL
 */
- (id)initWithSuperview:(UIView*)sview andFile:(NSString*)fName
{
    self = [super init];
    if (self) {
        // Initialization code here.
        bgView = [[[UIView alloc] initWithFrame: sview.bounds] autorelease];
        [sview addSubview: bgView];
        
        // proceed with animation after the bgView was added
        [self performSelector:@selector(doTransitionWithContentFile:) withObject:fName afterDelay:0.1];
    }
    
    return self;
}

/**
 * Afrer the window background is added to the UI the window can animate in
 * and load the UIWebView
 */
-(void)doTransitionWithContentFile:(NSString*)fName
{
    //faux view
    UIView* fauxView = [[[UIView alloc] initWithFrame: CGRectMake(10, 10, 200, 200)] autorelease];

    //the new panel
    bigPanelView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)] autorelease];
    bigPanelView.center = CGPointMake( bgView.frame.size.width/2, bgView.frame.size.height/2);
    
    //add the window background
    UIImageView * background = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popupWindowBack.png"]] autorelease];
    background.center = CGPointMake(bigPanelView.frame.size.width/2, bigPanelView.frame.size.height/2+30);
    
    //add the close button
    int closeBtnOffset = 10;
    UIImage* closeBtnImg = [UIImage imageNamed:@"popupCloseBtn.png"];
    UIButton* closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:closeBtnImg forState:UIControlStateNormal];
    [closeBtn setFrame:CGRectMake( background.frame.origin.x + background.frame.size.width - closeBtnImg.size.width - closeBtnOffset+12, 
                                  background.frame.origin.y -12 ,
                                  closeBtnImg.size.width + closeBtnOffset, 
                                  closeBtnImg.size.height + closeBtnOffset)];
    [closeBtn addTarget:self action:@selector(closePopupWindow) forControlEvents:UIControlEventTouchUpInside]; 
    
    //add the web view
    int webOffset = 10;
    UIWebView* web = [[[UIWebView alloc] initWithFrame:CGRectInset(background.frame, webOffset, webOffset)] autorelease];
    

    
    web.backgroundColor = [UIColor clearColor];
   
//    NSLog(@"Popupframe height:%f width:%f", web.frame.size.height, web.frame.size.width);
//    NSLog(@"Popup Window frame.height:%f",background.frame.size.height);
    
    
    if ([fName hasPrefix:@"http"]) {
        //load a web page
        web.scalesPageToFit = YES;
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: fName]]];
    } else {
        //load a local file
        NSError* error = nil;
        NSString* fileContents = [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fName] encoding:NSUTF8StringEncoding error: &error];
        if (error!=NULL) {
            NSLog(@"error loading %@: %@", fName, [error localizedDescription]);
        } else {
            [web loadHTMLString: fileContents baseURL:[NSURL URLWithString:@"file://"]];
        }
    }
    
    web.delegate=self;
    
    bigPanelView.hidden=YES;
    [bgView addSubview: fauxView];
    [bigPanelView addSubview: background];
    [bigPanelView addSubview: web];
    [bigPanelView addSubview: closeBtn];
    
    
    
    //animation options
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromRight |
                                        UIViewAnimationOptionAllowUserInteraction    |
                                        UIViewAnimationOptionBeginFromCurrentState;
    
    //run the animation
    [UIView transitionFromView:fauxView toView:bigPanelView duration:0.5 options:options completion: ^(BOOL finished) {
        
        //dim the contents behind the popup window
        UIView* shadeView = [[[UIView alloc] initWithFrame:bigPanelView.frame] autorelease];
        shadeView.backgroundColor = [UIColor blackColor];
        shadeView.alpha = 0.3;
        shadeView.tag = kShadeViewTag;
        [bigPanelView addSubview: shadeView];
        [bigPanelView sendSubviewToBack: shadeView];
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {     
    //NSLog(@"welcome page had starting");   
    
}

- (void)webViewDidFinishLoad:(UIWebView *)localwebView {
    //NSLog(@"welcome page had finished"); 
    //[localwebView sizeToFit];
    //localwebView.center = CGPointMake(localwebView.frame.size.width /2, localwebView.frame.size.height /2);
    bigPanelView.hidden=NO;
//    NSLog(@"webView height: %f width:%f", localwebView.frame.size.height, localwebView.frame.size.width);
}


/**
 * Removes the window background and calls the animation of the window
 */
-(void)closePopupWindow
{
    //remove the shade
       AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[bigPanelView viewWithTag: kShadeViewTag] removeFromSuperview];    
    [self performSelector:@selector(closePopupWindowAnimate) withObject:nil afterDelay:0.1];
    [appDelegate targetMethod];
    
}



/**
 * Animates the window and when done removes all views from the view hierarchy
 * since they are all only retained by their superview this also deallocates them
 * finally deallocate the class instance
 */
-(void)closePopupWindowAnimate
{
    
    //faux view 
    __block UIView* fauxView = [[[UIView alloc] initWithFrame: CGRectMake(10, 10, 200, 200)] autorelease] ;
    [bgView addSubview: fauxView];

    //run the animation
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromLeft |
    UIViewAnimationOptionAllowUserInteraction    |
    UIViewAnimationOptionBeginFromCurrentState;
    
    //hold to the bigPanelView, because it'll be removed during the animation
    [bigPanelView retain];
    
    [UIView transitionFromView:bigPanelView toView:fauxView duration:0.5 options:options completion:^(BOOL finished) {

        //when popup is closed, remove all the views
        for (UIView* child in bigPanelView.subviews) {
            [child removeFromSuperview];
        }
        for (UIView* child in bgView.subviews) {
            [child removeFromSuperview];
        }
        [bigPanelView release];
        [bgView removeFromSuperview];
        
        [self release];
    }];
}

@end