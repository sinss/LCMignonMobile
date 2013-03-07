//
//  rootViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/10.
//
//

#import "rootViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [coverFlow setDelegate:self];

}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}
- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return 64;
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
	switch (image % 6) {
		case 0:
		default:
			return [UIImage imageNamed:@"a.png"];
		case 1:
			return [UIImage imageNamed:@"b.png"];
		case 2:
			return [UIImage imageNamed:@"c.png"];
		case 3:
			return [UIImage imageNamed:@"x.png"];
		case 4:
			return [UIImage imageNamed:@"y.png"];
		case 5:
			return [UIImage imageNamed:@"z.png"];
	}
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
	NSLog(@"Selected Index %d",image);
}


@end
