//
//  productIntroductionCell.m
//  Mignon
//
//  Created by sinss on 13/3/21.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "productIntroductionCell.h"

@implementation productIntroductionCell
@synthesize priceLabel, stockLabel, itemNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [priceLabel release], priceLabel = nil;
    [stockLabel release], stockLabel = nil;
    [itemNameLabel release], itemNameLabel = nil;
    [super dealloc];
}

@end
