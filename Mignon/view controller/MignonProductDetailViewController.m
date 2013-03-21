//
//  MignonProductDetailViewController.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonProductDetailViewController.h"
#import "MathFunction.h"
#import "productInfo.h"
#import "productImageCell.h"
#import "productIntroductionCell.h"

@interface MignonProductDetailViewController ()

@end

@implementation MignonProductDetailViewController
@synthesize currentProduct;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [aTableView release];
    [currentProduct release];
    [super dealloc];
}

#pragma mark - UITableViewDataSource, UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (row == 0)
    {
        return 200;
    }
    else if (row == 1)
    {
        return 110;
    }
    return 40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productImageCellIdentifier = @"productImageCellIdentifier";
    static NSString *productIntroductionCellIdentifier = @"productIntroductionCellIdentifier";
    NSInteger row = [indexPath row];
    if (row == 0)
    {
        productImageCell *cell = [tableView dequeueReusableCellWithIdentifier:productImageCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"productImageCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[productImageCell class]])
                {
                    cell = currentObj;
                }
                break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        [cell createImageButtonWithImageUrl:currentProduct.imageArray];
        return cell;
    }
    else if (row == 1)
    {
        productIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:productIntroductionCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"productIntroductionCell" owner:self options:nil];
            for (id obj in topLevelObjects)
            {
                if ([obj isKindOfClass:[productIntroductionCell class]])
                {
                    cell = obj;
                }
                break;
            }
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.priceLabel setText:[[MathFunction mathFunctionInstance] displayDefaultNumberWithNumber:currentProduct.price]];
        [cell.itemNameLabel setText:currentProduct.itemName];
        [cell.stockLabel setText:[NSString stringWithFormat:@"%@",currentProduct.stock]];
        
        return cell;
    }
    return nil;
}

@end
