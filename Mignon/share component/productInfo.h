//
//  productInfo.h
//  Mignon
//
//  Created by sinss on 13/3/8.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface productInfo : NSObject
{
    NSNumber *showNo;
    NSString *showInd;
    NSString *category;
    NSString *itemName;
    NSNumber *price;
    NSNumber *discound;
    NSArray *sizes;
    NSArray *colors;
    NSNumber *stock;
    NSString *imageUrl;
    NSString *content;
    NSString *comment;
}

@property (nonatomic, retain) NSNumber *showNo;
@property (nonatomic, retain) NSString *showInd;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, retain) NSNumber *price;
@property (nonatomic, retain) NSNumber *discound;
@property (nonatomic, retain) NSArray *sizes;
@property (nonatomic, retain) NSArray *colors;
@property (nonatomic, retain) NSNumber *stock;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *comment;

@end
