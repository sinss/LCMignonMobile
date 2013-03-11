//
//  moreInfo.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "moreInfo.h"

@implementation moreInfo
@synthesize itemTitle, itemType, itemContent, seq;

- (void)dealloc
{
    [itemTitle release], itemTitle = nil;
    [itemType release], itemType = nil;
    [itemContent release], itemContent = nil;
    [seq release], seq = nil;
    [super dealloc];
}
@end
