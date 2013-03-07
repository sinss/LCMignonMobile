//
//  ErrorViewController.m
//  SlyCool001Project
//
//  Created by Wan Jung Liu on 12/2/2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ErrorViewController.h"
#import "AppDelegate.h"

@implementation ErrorViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    errorImageView.frame = CGRectMake(0, 20, 320, 460);
    errorImageView.autoresizesSubviews= YES;
    [self.view addSubview:errorImageView]; 
    

  
    UIButton *reflashButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	reflashButton.frame = CGRectMake(83, 55, 155, 155);
	//[htmlCopy setTitle:copybuttonstring forState:UIControlStateNormal];
	[reflashButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	reflashButton.backgroundColor = [UIColor clearColor];
    [reflashButton addTarget:self action:@selector(reflash:) forControlEvents:UIControlEventTouchUpInside];
	[reflashButton setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    [self.view addSubview:reflashButton]; 

  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"錯誤" message:@"可能是網路問題造成無法連線，請稍後再試..."
                                                   delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [reflashButton release];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)reflash:(id)Sender {
    [self performSelector:@selector(reflash) withObject:nil afterDelay:1];

}

- (void)reflash
{
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"Button 1"])
	{
		NSLog(@"Button 1 was selected.");
	}
}
@end
