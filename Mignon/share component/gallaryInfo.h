//
//  gallaryInfo.h
//  Mignon
//
//  Created by sinss on 13/3/13.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gallaryInfo : NSObject
{
    NSNumber *seq;
    NSString *showInd;
    NSString *imageUrl;
    NSString *title;
    NSArray *itemTitles;
    NSArray *itemContents;
}

@property (nonatomic, retain) NSNumber *seq;
@property (nonatomic, retain) NSString *showInd;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray *itemTitles;
@property (nonatomic, retain) NSArray *itemContents;

@end