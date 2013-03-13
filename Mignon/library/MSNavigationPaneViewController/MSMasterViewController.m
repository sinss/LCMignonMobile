//
//  MSMasterViewController.m
//  MSNavigationPaneViewController
//
//  Created by Eric Horacek on 11/20/12.
//  Copyright (c) 2012 Monospace Ltd. All rights reserved.
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
#import "MSMasterViewController.h"
#import "MignonNewsViewController.h"
#import "MignonProductViewController.h"
#import "MignonShopCartViewController.h"
#import "MignonFacebookViewController.h"
#import "MignonShareViewController.h"
#import "MignonMoreViewController.h"
#import "appConfigRecord.h"

NSString * const MSMasterViewControllerCellReuseIdentifier = @"MSMasterViewControllerCellReuseIdentifier";

typedef NS_ENUM(NSUInteger, MSMasterViewControllerTableViewSectionType) {
    MSMasterViewControllerTableViewSectionTypeColors,
    MSMasterViewControllerTableViewSectionTypeAbout,
    MSMasterViewControllerTableViewSectionTypeCount,
};

@interface MSMasterViewController ()

@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;
@property (nonatomic, strong) NSDictionary *paneViewControllerTintColor;
@property (nonatomic, strong) NSDictionary *paneViewControllerClasses;
@property (nonatomic, strong) NSArray *tableViewSectionBreaks;

@end

@implementation MSMasterViewController

#pragma mark - UIViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.paneViewControllerType = NSUIntegerMax;
        self.paneViewControllerTitles = @{
            @(MignonViewControllerTypeNews) : @"促銷活動",
            @(MignonViewControllerTypeProduct) : @"商品列表",
            @(MignonViewControllerTypeShopCart) : @"我的最愛",
            @(MignonViewControllerTypeFacebook) : @"精選分享",
            @(MignonViewControllerTypeMore) : @"關於我們",
        };
        self.paneViewControllerClasses = @{
            @(MignonViewControllerTypeNews) : MignonNewsViewController.class,
            @(MignonViewControllerTypeProduct) : MignonProductViewController.class,
            @(MignonViewControllerTypeShopCart) : MignonShopCartViewController.class,
            @(MignonViewControllerTypeFacebook) : MignonShareViewController.class,
            @(MignonViewControllerTypeMore) : MignonMoreViewController.class,
        };
        self.paneViewControllerTintColor = @{
            @(MignonViewControllerTypeNews) : [UIColor colorWithRed:230.f/255 green:71.f/255 blue:135.f/255 alpha:1.000],
            @(MignonViewControllerTypeProduct) : [UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000],
            @(MignonViewControllerTypeShopCart) : [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000],
            @(MignonViewControllerTypeFacebook) : [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1],
            @(MignonViewControllerTypeMore) : [UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000],
        };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImageView *sbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarbg"]];
    [sbg setContentMode:UIViewContentModeScaleAspectFill];
    [sbg setFrame:self.tableView.bounds];
    [self.tableView setBackgroundView:sbg];
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - MSMasterViewController

#pragma mark section0 
- (MignonViewControllerType)panelViewControllerTypeForIndexPath:(NSIndexPath*)indexPath
{
    MignonViewControllerType paneViewControllerType;
    paneViewControllerType = indexPath.row;
    
    NSAssert(paneViewControllerType < MignonViewControllerTypeCount, @"Invalid Index Path");
    return paneViewControllerType;
}

#pragma mrak Section0 transition
- (void)transitionToViewController:(MignonViewControllerType)paneViewControllerType
{
    BOOL animateTransition = self.navigationPaneViewController.paneViewController != nil;
    
    Class paneViewControllerClass = self.paneViewControllerClasses[@(paneViewControllerType)];
    NSParameterAssert([paneViewControllerClass isSubclassOfClass:UIViewController.class]);
    UIViewController *paneViewController = (UIViewController *)[[paneViewControllerClass alloc] init];
    paneViewController.navigationItem.title = self.paneViewControllerTitles[@(paneViewControllerType)];
    paneViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MSBarButtonIconNavigationPane.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(navigationPaneBarButtonItemTapped:)];
    
    UINavigationController *paneNavigationViewController = [[UINavigationController alloc] initWithRootViewController:paneViewController];
    paneNavigationViewController.navigationBar.tintColor = self.paneViewControllerTintColor[@(paneViewControllerType)];
    paneNavigationViewController.toolbar.tintColor = self.paneViewControllerTintColor[@(paneViewControllerType)];
    
    [self.navigationPaneViewController setPaneViewController:paneNavigationViewController animated:animateTransition completion:nil];
    
    self.paneViewControllerType = paneViewControllerType;
}

- (void)navigationPaneBarButtonItemTapped:(id)sender;
{
    [self.navigationPaneViewController setPaneState:MSDraggableViewStateOpen animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.paneViewControllerTitles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shareHeader2.png"]];
    [imageview setFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,
                                                               self.view.frame.size.width,
                                                               20)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"主選單"];
    [imageview addSubview:label];
    return imageview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MSMasterViewControllerCellReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MSMasterViewControllerCellReuseIdentifier];
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]];
        [bg setFrame:CGRectMake(0, 0, 199.5, 42.5)];
        [cell setBackgroundView:bg];
        [cell.textLabel setTextColor:[UIColor lightGrayColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    }
    cell.textLabel.text = self.paneViewControllerTitles[@([self panelViewControllerTypeForIndexPath:indexPath])];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self transitionToViewController:[self panelViewControllerTypeForIndexPath:indexPath]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
