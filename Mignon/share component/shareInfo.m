//
//  shareInfo.m
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "shareInfo.h"

@implementation shareInfo
@synthesize shareNo, shareTitle, shareContent, imageUrl, sourceUrl, showInd, showInTableView;

- (void)dealloc
{
    [shareNo release], shareNo = nil;
    [shareTitle release], shareTitle = nil;
    [shareContent release], shareContent = nil;
    [imageUrl release], imageUrl = nil;
    [sourceUrl release], sourceUrl = nil;
    [showInd release], showInd = nil;
    [super dealloc];
}

@end
