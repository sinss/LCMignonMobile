//
//  MignonProductDetailViewController.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class productInfo;
@interface MignonProductDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *aTableView;
    productInfo *currentProduct;
}

@property (nonatomic, retain) productInfo *currentProduct;

@end
