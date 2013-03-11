//
//  productCell.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "productCell.h"
#import "StrikeThroughLabel.h"

@implementation productCell
@synthesize categoryLabel, titleLabel, priceLabel;

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

- (void)setPriceDeleteLineEnable:(BOOL)isOn andText:(NSString*)text
{
    [priceLabel setText:[NSString stringWithFormat:@"$%@",text]];
    [priceLabel setStrikeThroughEnabled:isOn];
    [self addSubview:priceLabel];
}

- (void) dealloc
{
    [priceLabel release], priceLabel = nil;
    [categoryLabel release], categoryLabel = nil;
    [titleLabel release],  titleLabel = nil;
    [super dealloc];
}

@end
