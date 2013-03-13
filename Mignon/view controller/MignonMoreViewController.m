//
//  MignonMoreViewController.m
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonMoreViewController.h"
#import "downloadStoreDelegate.h"
#import "appConfigRecord.h"
#import "ODRefreshControl.h"
#import "BrowserViewController.h"
#import "appConfigRecord.h"
#import "MapViewController.h"

@interface MignonMoreViewController () <downloadStoreListProcess>
{
    downloadStoreDelegate *downloadNews;
}

@property (nonatomic, retain) NSArray *moreArray;

- (void)startGetMoreContentWithRefreshInd:(NSString*)refreshInd;

@end

@implementation MignonMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (downloadNews == nil)
        {
            downloadNews = [[downloadStoreDelegate alloc] initWithURL:[[appConfigRecord appConfigInstance] tabURL5]];
            [downloadNews setCsvLoadtype:csvLoadTypeMore];
            [downloadNews setDelegate:self];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *emptyView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [aTableView setTableFooterView:emptyView];
    
    [aTableView setDelegate:self];
    [aTableView setDataSource:self];
    
    if (HUD == nil && [HUD retainCount] == 0)
    {
        NSLog(@"Launch View(start)");
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.dimBackground = YES;
        HUD.delegate = self;
        HUD.labelText = @"資料讀取中...";
        [HUD showWhileExecuting:@selector(startGetMoreContentWithRefreshInd:) onTarget:self withObject:@"NO" animated:YES];
    }
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:aTableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_moreArray release], _moreArray = nil;
    [aTableView release];
    [super dealloc];
}

- (void)startGetMoreContentWithRefreshInd:(NSString*)refreshInd
{
    if([refreshInd isEqualToString:@"YES"])
        [downloadNews startGetStoreWithRefreshing:YES];
    else
        [downloadNews startGetStoreWithRefreshing:NO];
}

#pragma mark - downloadStoreDelegate
- (void)downloadDelegate:(downloadStoreDelegate *)obj didFaildDownloadWithError:(NSString *)errorMessage
{
    NSLog(@"download news fail");
}

- (void)downloadDelegate:(downloadStoreDelegate *)obj didFinishDownloadWithData:(NSArray *)storeArray
{
    self.moreArray = [NSArray arrayWithArray:storeArray];
    [aTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - ODRefreshControl refresh function
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [self performSelector:@selector(startGetMoreContentWithRefreshInd:) withObject:@"YES"];
                       [refreshControl endRefreshing];
                   });
}

#pragma mark - UITableViewDataSource, UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.moreArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *moreCellIdentifier = @"moreCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
    NSInteger row = [indexPath row];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:moreCellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
    }
    moreInfo *info = [self.moreArray objectAtIndex:row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",info.itemTitle]];
    if ([info.itemType isEqualToString:@"0"])
    {
        [cell.detailTextLabel setText:info.itemContent];
    }
    else if ([info.itemType isEqualToString:@"1"])
    {
        [cell.detailTextLabel setText:@"網址"];
    }
    else if ([info.itemType isEqualToString:@"2"])
    {
        [cell.detailTextLabel setText:@"連絡我"];
    }
    else if ([info.itemType isEqualToString:@"3"])
    {
        [cell.detailTextLabel setText:@"地圖"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     0:一般文字
     1:網址
     2:email
     3:地圖
     */
    NSInteger row = [indexPath row];
    moreInfo *info = [self.moreArray objectAtIndex:row];
    if ([info.itemType isEqualToString:@"1"])
    {
        NSURL *url = [NSURL URLWithString:info.itemContent];
        BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:url];
        [self.navigationController pushViewController:bvc animated:YES];
        [bvc release];
    }
    else if ([info.itemType isEqualToString:@"3"])
    {
        //NSString *googleMapUrl = [NSString stringWithFormat:@"comgooglemaps://?q=&center=%@,%@",[[appConfigRecord appConfigInstance] latitude],[[appConfigRecord appConfigInstance] longitude]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapUrl]];
        MapViewController *mapView = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        [self.navigationController pushViewController:mapView animated:YES];
        [mapView release];
    }
}

@end
