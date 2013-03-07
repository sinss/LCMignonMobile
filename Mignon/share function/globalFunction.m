//
//  globalFunction.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "globalFunction.h"

@implementation globalFunction

+ (NSString *)formatDistance:(NSInteger ) distance
{
    NSString *distanceResult = nil ;
    if (distance >= 1000) {
        distanceResult =  [[NSString alloc] initWithFormat:@"%.2f公里",distance/1000.00];
    }else{
        distanceResult = [[NSString alloc] initWithFormat:@"%d公尺",distance] ;
    }
    return [distanceResult autorelease] ;
    
}

+ (NSString*) getCacheDirectory
{
    NSArray *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *fileName  = [cacheDir objectAtIndex:0];
    return fileName;
}

+ (NSString*)getCacheDirectoryFileNameWithName:(NSString*)name
{
    NSArray *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *fileName  = [cacheDir objectAtIndex:0];
    fileName = [fileName stringByAppendingPathComponent:name];
    return fileName;
}

+ (NSString *)getTodayString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];//test duedate
    NSString *today = [dateFormat stringFromDate:[NSDate date]];
    [dateFormat release];
    return today;
}

@end
