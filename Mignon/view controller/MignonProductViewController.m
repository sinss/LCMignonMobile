//
//  MignonProductViewController.m
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonProductViewController.h"
#import "downloadStoreDelegate.h"
#import "appConfigRecord.h"
#import "ODRefreshControl.h"

@interface MignonProductViewController () <UISearchBarDelegate, downloadStoreListProcess>
{
    downloadStoreDelegate *downloadNews;
}

@property (nonatomic, retain) NSArray *productArray;

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSMutableArray *fetchProductArray;
@property (nonatomic, retain) NSMutableString *searchKey;

- (void)createSearchBar;
- (void)fetchRresult;

- (void)startGetProductContentWithRefreshInd:(NSString*)refreshInd;

@end

@implementation MignonProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (downloadNews == nil)
        {
            downloadNews = [[downloadStoreDelegate alloc] initWithURL:[[appConfigRecord appConfigInstance] tabURL2]];
            [downloadNews setCsvLoadtype:csvLoadtypeProduct];
            [downloadNews setDelegate:self];
        }
        if (_searchKey == nil)
        {
            _searchKey = [[NSMutableString alloc] initWithCapacity:0];
        }
        if (_fetchProductArray == nil)
        {
            _fetchProductArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        if (_productArray == nil)
        {
            _productArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSearchBar];
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
        [HUD showWhileExecuting:@selector(startGetProductContentWithRefreshInd:) onTarget:self withObject:@"YES" animated:YES];
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
    [_fetchProductArray release], _fetchProductArray = nil;
    [_searchKey release], _searchKey = nil;
    [_productArray release], _productArray = nil;
    [_searchBar release], _searchBar = nil;
    [super dealloc];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self.searchKey setString:[searchBar text]];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - createBarItem
- (void)createSearchBar
{
    if (self.searchBar == nil)
    {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        [self.searchBar setTintColor:self.navigationController.navigationBar.tintColor];
        self.searchBar.layer.borderWidth = 0;
        [self.searchBar setPlaceholder:[NSString stringWithFormat:@"關鍵字搜尋"]];
        [self.searchBar setDelegate:self];
        //建立 toolbar
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        toolbar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"收合" style:UIBarButtonItemStyleBordered target:self action:@selector(closeKeyboard)];
        [toolbar setItems:[NSArray arrayWithObjects:flexItem,closeItem, nil]];
        [self.searchBar setInputAccessoryView:toolbar];
        [flexItem release];
        [closeItem release];
        [toolbar release];
        
    }
    self.navigationItem.titleView = self.searchBar;
    [aTableView setContentOffset:CGPointMake(0,40) animated:NO];
}

- (void)closeKeyboard
{
    [self.searchBar resignFirstResponder];
}

- (void)startDownloadProductList
{
    
}

- (void)fetchRresult
{
    NSMutableString *tmp = [NSMutableString stringWithCapacity:0];
    if ([self.searchKey length] == 0)
    {
        [tmp setString:@"1=1"];
    }
    else
    {
        
    }
    [self.fetchProductArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:tmp];
    NSArray *tmpArray = [self.productArray filteredArrayUsingPredicate:predicate];
    [self.fetchProductArray addObjectsFromArray:tmpArray];
    [aTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)startGetProductContentWithRefreshInd:(NSString*)refreshInd;
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
    self.productArray = [NSArray arrayWithArray:storeArray];
    [self fetchRresult];
}

#pragma mark - ODRefreshControl refresh function
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [self performSelector:@selector(startGetProductContentWithRefreshInd:) withObject:@"YES"];
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
    return [self.fetchProductArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsCellIdentifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
    NSInteger row = [indexPath row];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:newsCellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
    }
    productInfo *info = [self.fetchProductArray objectAtIndex:row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@, %@, %@",info.itemName, info.price, info.discound]];
    [cell.detailTextLabel setText:info.content];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
