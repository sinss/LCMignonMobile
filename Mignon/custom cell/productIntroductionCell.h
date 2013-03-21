//
//  productIntroductionCell.h
//  Mignon
//
//  Created by sinss on 13/3/21.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productIntroductionCell : UITableViewCell
{
    UILabel *priceLabel;
    UILabel *stockLabel;
    UILabel *itemNameLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *stockLabel;
@property (nonatomic, retain) IBOutlet UILabel *itemNameLabel;

@end
