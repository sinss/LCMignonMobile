//
//  newsInfo.m
//  Mignon
//
//  Created by sinss on 13/3/8.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "newsInfo.h"

@implementation newsInfo
@synthesize showId, title, content, url, start, end, showInd;

- (void)dealloc
{
    [showId release], showId = nil;
    [title release], title = nil;
    [content release], content = nil;
    [url release], url = nil;
    [start release], start = nil;
    [end release], end = nil;
    [showInd release], showInd = nil;
    [super dealloc];
}
@end
