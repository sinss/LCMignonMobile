//
//  moreInfo.h
//  Mignon
//
//  Created by sinss on 13/3/11.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moreInfo : NSObject
{
    NSString *itemTitle;
    NSString *itemType;
    NSString *itemContent;
    NSNumber *seq;
}

@property (nonatomic , retain) NSString *itemTitle;
@property (nonatomic , retain) NSString *itemType;
@property (nonatomic , retain) NSString *itemContent;
@property (nonatomic , retain) NSNumber *seq;

@end
