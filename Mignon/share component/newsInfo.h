//
//  newsInfo.h
//  Mignon
//
//  Created by sinss on 13/3/8.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsInfo : NSObject
{
    NSNumber *showId;
    NSString *title;
    NSString *content;
    NSString *url;
    NSString *start;
    NSString *end;
    NSString *showInd;
}

@property (nonatomic, retain) NSNumber *showId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *start;
@property (nonatomic, retain) NSString *end;
@property (nonatomic, retain) NSString *showInd;

@end
