//
//  productInfo.m
//  Mignon
//
//  Created by sinss on 13/3/8.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "productInfo.h"

@implementation productInfo
@synthesize showInd, showNo, category, itemName, price, discound, sizes, colors, stock, imageArray, content, comment;

- (void)dealloc
{
    [showInd release], showInd = nil;
    [showNo release], showNo = nil;
    [category release], category = nil;
    [itemName release], itemName = nil;
    [price release], price = nil;
    [discound release], discound = nil;
    [sizes release], sizes = nil;
    [colors release], colors = nil;
    [stock release], stock = nil;
    [imageArray release], imageArray = nil;
    [content release], content = nil;
    [comment release], comment = nil;
    [super dealloc];
}
@end
