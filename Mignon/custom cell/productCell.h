//
//  productCell.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StrikeThroughLabel;
@interface productCell : UITableViewCell
{
    StrikeThroughLabel *priceLabel;
    UILabel *categoryLabel;
    UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet StrikeThroughLabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

- (void)setPriceDeleteLineEnable:(BOOL)isOn andText:(NSString*)text;

@end
