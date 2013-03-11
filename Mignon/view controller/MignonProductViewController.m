//
//  MignonProductViewController.m
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonProductViewController.h"
#import "MathFunction.h"
#import "downloadStoreDelegate.h"
#import "appConfigRecord.h"
#import "ODRefreshControl.h"
#import "productCell.h"
#import "MignonProductDetailViewController.h"

@interface MignonProductViewController () <downloadStoreListProcess>
{
    downloadStoreDelegate *downloadNews;
}

@property (nonatomic, retain) NSArray *productArray;


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
    [_productArray release], _productArray = nil;
    [aTableView release], aTableView = nil;
    [super dealloc];
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
    [aTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    return [self.productArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productCellIdentifier = @"productCellIdentifier";
    NSInteger row = [indexPath row];
    productCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"productCell" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[productCell class]])
            {
                cell = currentObj;
            }
            break;
        }
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    productInfo *info = [self.productArray objectAtIndex:row];
    [cell.categoryLabel setText:info.category];
    [cell.titleLabel setText:info.itemName];
    if ([info.discound doubleValue] > 0)
    {
        [cell setPriceDeleteLineEnable:YES andText:[[MathFunction mathFunctionInstance] displayDefaultNumberWithNumber:info.price]];
    }
    else
    {
        [cell setPriceDeleteLineEnable:NO andText:[[MathFunction mathFunctionInstance] displayDefaultNumberWithNumber:info.price]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MignonProductDetailViewController *productDetailView = [[MignonProductDetailViewController alloc] initWithNibName:@"MignonProductDetailViewController" bundle:nil];
    productInfo *info = [self.productArray objectAtIndex:[indexPath row]];
    [productDetailView setCurrentProduct:info];
    [self.navigationController pushViewController:productDetailView animated:YES];
    [productDetailView release];
}


@end
