//
//  customTextViewCell.m
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "customTextViewCell.h"

@implementation customTextViewCell
@synthesize contentTextView;

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
    [contentTextView release], contentTextView = nil;
    [super dealloc];
}

@end
