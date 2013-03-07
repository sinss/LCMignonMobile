//
//  globalFunction.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface globalFunction : NSObject

+ (NSString*)formatDistance:(NSInteger ) distance;
+ (NSString*) getCacheDirectory;
+ (NSString*)getCacheDirectoryFileNameWithName:(NSString*)name;
+ (NSString*)getTodayString;
@end
