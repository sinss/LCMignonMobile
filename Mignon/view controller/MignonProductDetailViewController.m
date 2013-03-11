//
//  MignonProductDetailViewController.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonProductDetailViewController.h"
#import "productInfo.h"
#import "productImageCell.h"

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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = [indexPath section];
    if (sec == 0)
    {
        return 200;
    }
    return 40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productImageCellIdentifier = @"productImageCellIdentifier";
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

@end
