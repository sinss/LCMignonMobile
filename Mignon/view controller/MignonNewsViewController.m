//
//  MignonNewsViewController.m
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonNewsViewController.h"
#import "downloadStoreDelegate.h"
#import "appConfigRecord.h"
#import "ODRefreshControl.h"
#import "BrowserViewController.h"


@interface MignonNewsViewController () <downloadStoreListProcess>
{
    downloadStoreDelegate *downloadNews;
}

@property (nonatomic, retain) NSArray *newsArray;

- (void)startGetNewsContentWithRefreshInd:(NSString*)refreshInd;

@end

@implementation MignonNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (downloadNews == nil)
        {
            downloadNews = [[downloadStoreDelegate alloc] initWithURL:[[appConfigRecord appConfigInstance] tabURL1]];
            [downloadNews setCsvLoadtype:csvLoadtypeNews];
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
         [HUD showWhileExecuting:@selector(startGetNewsContentWithRefreshInd:) onTarget:self withObject:@"NO" animated:YES];
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
    [_newsArray release], _newsArray = nil;
    [aTableView release];
    [super dealloc];
}

- (void)startGetNewsContentWithRefreshInd:(NSString*)refreshInd
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
    self.newsArray = [NSArray arrayWithArray:storeArray];
    [aTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - ODRefreshControl refresh function
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [self performSelector:@selector(startGetNewsContentWithRefreshInd:) withObject:@"YES"];
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
    return [self.newsArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsCellIdentifier = @"newsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
    NSInteger row = [indexPath row];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:newsCellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
    }
    newsInfo *info = [self.newsArray objectAtIndex:row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ ~ %@, %@",info.start, info.end, info.title]];
    [cell.detailTextLabel setText:info.content];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    newsInfo *info = [self.newsArray objectAtIndex:row];
    BrowserViewController *browserView = [[BrowserViewController alloc] initWithUrls:[NSURL URLWithString:info.url]];
    [self.navigationController pushViewController:browserView animated:YES];
    [browserView release];
}
@end
