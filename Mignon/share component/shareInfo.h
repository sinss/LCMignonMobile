//
//  shareInfo.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shareInfo : NSObject
{
    NSNumber *shareNo;
    NSString *shareTitle;
    NSString *shareContent;
    NSString *imageUrl;
    NSString *sourceUrl;
    NSString *showInd;
    BOOL showInTableView;
}

@property (nonatomic, retain) NSNumber *shareNo;
@property (nonatomic, retain) NSString *shareTitle;
@property (nonatomic, retain) NSString *shareContent;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *sourceUrl;
@property (nonatomic, retain) NSString *showInd;
@property (assign) BOOL showInTableView;

@end
