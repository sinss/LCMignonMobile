//
//  shareHeaderView2.m
//  pccuPrject
//
//  Created by sinss on 12/11/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "shareHeaderView2.h"
#import "AutoScrollLabel.h"

@implementation shareHeaderView2

@synthesize titleLabel, autoScrollInd;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [titleLabel release], titleLabel = nil;
    [super dealloc];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (autoScrollInd)
    {
        AutoScrollLabel *autoScrollLabel = [[AutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)];
        [autoScrollLabel setText:titleLabel.text];
        [autoScrollLabel setScrollDirection:AUTOSCROLL_SCROLL_RIGHT];
        [autoScrollLabel setPauseInterval:0.5];
        [autoScrollLabel setBufferSpaceBetweenLabels:0];
        [autoScrollLabel scroll];
        [self addSubview:autoScrollLabel];
        [autoScrollLabel release];
        [titleLabel setHidden:YES];
    }
}


@end
