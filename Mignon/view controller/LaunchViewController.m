//
//  LaunchViewController.m
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/26.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import "LaunchViewController.h"
#import "AppDelegate.h"
#import "MTPopupWindow.h"
#import "appConfigRecord.h"
#import "appDateRecord.h"

@interface LaunchViewController()

- (void)reloadAppConfig;

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (void)dealloc
{
    [HUD release], HUD = nil;
    [launchImageView release], launchImageView = nil;
    [downloadProcess release], downloadProcess = nil;
    [downloadProcess2 release], downloadProcess2 = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (downloadProcess == nil)
    {
        downloadProcess = [[downloadStoreDelegate alloc] initWithURL:appconfigURL];
        downloadProcess.csvLoadtype = csvLoadtypeConfig;
    }
    CGFloat height;
    if (IS_IPHONE_5)
    {
        height = 588;
    }
    else
    {
        height = 480;
    }
    UIImage *launchImage = [UIImage imageNamed:@"Default.png"];
    launchImageView = [[UIImageView alloc] initWithImage:launchImage];
    launchImageView.frame = CGRectMake(0, 10, 320, height);
    //launchImageView.autoresizesSubviews= YES;
    [self.view addSubview:launchImageView];     
    if(HUD == nil && [HUD retainCount]==0)
    {
        NSLog(@"Launch View(start)");   
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        /*
        HUD.dimBackground = YES;
        HUD.delegate = self;
        HUD.labelText = @"資料讀取中...";
        [HUD showWhileExecuting:@selector(reloadAppConfig) onTarget:self withObject:nil animated:YES];
         */
        
        HUD.dimBackground = YES;
        HUD.delegate = self;
        HUD.labelText = @"資料讀取中 . . .";
        [HUD show:NO];
    }
    [self reloadAppConfig];
    [self loadWebPage];
}

- (void)loadWebPage
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate targetMethod];
}
- (void)viewDidUnload
{
    if(HUD != nil)
    {
        NSLog(@"Launch View(finish)");
        [HUD hide:YES afterDelay:0];
		[HUD removeFromSuperview];
	}
    [super viewDidUnload];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - download process

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    if (obj.csvLoadtype == csvLoadtypeConfig)
        [downloadProcess release], downloadProcess = nil;
    else if (obj.csvLoadtype == csvLoadtypeDayURL)
        [downloadProcess2 release], downloadProcess2 = nil;
}
- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)array
{
    
    if (obj.csvLoadtype == csvLoadtypeConfig)
    {
        [downloadProcess release], downloadProcess = nil;
        NSString *url = [[appConfigRecord appConfigInstance] dayURL];
        downloadProcess2 = [[downloadStoreDelegate alloc] initWithURL:url];
        [downloadProcess2 setDelegate:self];
        downloadProcess2.csvLoadtype = csvLoadtypeDayURL;
    }
    else if (obj.csvLoadtype == csvLoadtypeDayURL)
    {
        [downloadProcess2 release], downloadProcess2 = nil;
    }
}

- (void)reloadAppConfig
{
    [downloadProcess startGetStoreWithRefreshing:YES];
    if (downloadProcess2 == nil)
    { 
        NSString *day = [[appConfigRecord appConfigInstance] dayURL];
        if (day != nil)
        {
            downloadProcess2 = [[downloadStoreDelegate alloc] initWithURL:day];
            downloadProcess2.csvLoadtype = csvLoadtypeDayURL;
            [downloadProcess2 startGetStoreWithRefreshing:NO];
        }
        /*
        NSString *brandUrl = [[appConfigRecord appConfigInstance] tabURL3];
        if (brandUrl != nil)
        {
            downloadProcess3 = [[downloadStoreDelegate alloc] initWithURL:brandUrl];
            downloadProcess3.csvLoadtype = csvLoadtypeBrand;
            [downloadProcess3 startGetStoreWithRefreshing:NO];
        }
         */
        /*
        NSString *topicUrl = [[appConfigRecord appConfigInstance] tabURL2];
        if (topicUrl != nil)
        {
            downloadProcess4 = [[downloadStoreDelegate alloc] initWithURL:topicUrl];
            downloadProcess4.csvLoadtype = csvLoadtypeTopic;
            [downloadProcess4 startGetStoreWithRefreshing:NO];
        }
         */
    }
}

@end
