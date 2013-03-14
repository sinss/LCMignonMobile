//
//  MignonShareViewController.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonShareViewController.h"
#import "downloadStoreDelegate.h"
#import "appConfigRecord.h"
#import "ODRefreshControl.h"
#import "BrowserViewController.h"
#import "customTextViewCell.h"

#define lineWords 21
#define lineHeight 22
#define lineBasicHeight 40

@interface MignonShareViewController () <downloadStoreListProcess>
{
    downloadStoreDelegate *downloadNews;
}

@property (nonatomic, retain) NSArray *shareArray;

- (void)startGetShareContentWithRefreshInd:(NSString*)refreshInd;

@end

@implementation MignonShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        if (downloadNews == nil)
        {
            downloadNews = [[downloadStoreDelegate alloc] initWithURL:[[appConfigRecord appConfigInstance] tabURL4]];
            [downloadNews setCsvLoadtype:csvLoadTypeShare];
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
        [HUD showWhileExecuting:@selector(startGetShareContentWithRefreshInd:) onTarget:self withObject:@"NO" animated:YES];
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
    [_shareArray release], _shareArray = nil;
    [aTableView release];
    [super dealloc];
}

- (void)startGetShareContentWithRefreshInd:(NSString*)refreshInd
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
    self.shareArray = [NSArray arrayWithArray:storeArray];
    //[aTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [storeArray count] - 1)] withRowAnimation:UITableViewRowAnimationAutomatic];
    [aTableView reloadData];
}

#pragma mark - ODRefreshControl refresh function
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       [self performSelector:@selector(startGetShareContentWithRefreshInd:) withObject:@"YES"];
                       [refreshControl endRefreshing];
                   });
}

#pragma mark - UITableViewDataSource, UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.shareArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    shareInfo *info = [self.shareArray objectAtIndex:section];
    if (info.showInTableView)
        return 1;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = [indexPath section];
    shareInfo *info = [self.shareArray objectAtIndex:sec];
    double lineNo = [info.shareContent length] / lineWords;
    if ([info.shareContent length] % lineWords == 0)
        return lineHeight * lineNo + lineBasicHeight;
    return lineHeight * (lineNo + 1) + lineBasicHeight;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 40);
    UIView *titleView = [[[UIView alloc] initWithFrame:rect] autorelease];
    UIImageView *imageView;
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0 , 250, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 60, 40)];
    shareInfo *info = [self.shareArray objectAtIndex:section];
    [headerButton setTitle:info.shareTitle forState:UIControlStateNormal];
    if (info.showInTableView)
        [label setText:[NSString stringWithFormat:@"↓"]];
    else
        [label setText:[NSString stringWithFormat:@"→"]];
    
    imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell.png"]] autorelease];

    [headerButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [headerButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [headerButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [headerButton setTag:section];
    [headerButton addTarget:self action:@selector(headerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor darkTextColor]];
    imageView.frame = rect;
    [titleView addSubview:imageView];
    [titleView addSubview:label];
    [titleView addSubview:headerButton];
    return titleView;
}

- (void)headerButtonPress:(UIButton*)sender
{
    NSInteger tag = [sender tag];
    shareInfo *info = [self.shareArray objectAtIndex:tag];
    info.showInTableView = !(info.showInTableView);
    [aTableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *shareCellIdentifier = @"shareCellIdentifier";
    NSInteger sec = [indexPath section];
    customTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shareCellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextViewCell" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[customTextViewCell class]])
            {
                cell = currentObj;
            }
            break;
        }
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    shareInfo *info = [self.shareArray objectAtIndex:sec];
    double lineNo = [info.shareContent length] / lineWords;
    double height = 0;
    if ([info.shareContent length] % lineWords == 0)
    {
        height = lineHeight * lineNo + lineBasicHeight;
    }
    else
    {
        height = lineHeight * (lineNo + 1) + lineBasicHeight;
    }
    [cell.contentTextView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, height)];
    [cell.contentTextView setText:[NSString stringWithFormat:@"%@",info.shareContent]];
    [cell.contentTextView sizeToFit];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
