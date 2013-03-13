//
//  gallaryInfo.m
//  Mignon
//
//  Created by sinss on 13/3/13.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "gallaryInfo.h"

@implementation gallaryInfo
@synthesize seq, showInd, imageUrl, title, itemContents, itemTitles;

- (void)dealloc
{
    [seq release], seq = nil;
    [showInd release], showInd = nil;
    [imageUrl release], imageUrl = nil;
    [title release], title = nil;
    [itemTitles release], itemTitles = nil;
    [itemContents release], itemContents = nil;
    [super dealloc];
}

@end
