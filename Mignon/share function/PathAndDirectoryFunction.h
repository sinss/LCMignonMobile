//
//  PathAndDirectoryFunction.h
//  MLIproposal
//
//  Created by 張星星 on 12/5/19.
//  Copyright (c) 2012年 Mountant Star Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define reportDirectoryName @"report"
#define saveDataDirectoryName @"saveData"
#define infoDirectoryName @"info"
#define provisionDirectoryName @"provision"
#define introDirectoryName @"intro"
#define dmDirectoryName @"dm"
#define classDirectoryName @"class"
#define catalogDirectoryName @"catalog"

@interface PathAndDirectoryFunction : NSObject

+ (NSString*)getDocumentDirectoryWithAgentCode:(NSString*)agid;
+ (NSString*)getReportDriectoryInDocumentWithAgentCode:(NSString*)agid;
+ (NSString*)getReportPathInDocumentWithAgentCode:(NSString*)agid andFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getSavedataDriectoryInDocumentWithAgentCode:(NSString*)agid;
+ (NSString*)getSavedataPathInDocumentWithAgentCode:(NSString*)agid andFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getInfoDriectoryInDocumentWithAgentCode:(NSString*)agid;
+ (NSString*)getInfoPathInDocumentWithAgentCode:(NSString*)agid andFileName:(NSString*)file andExtension:(NSString*)ext;

+ (NSString*)getDocumentPathWithFileName:(NSString*)fileName andExtension:(NSString*)ext;
+ (NSString*)getTempPathWithFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getCachePathWithFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getProvisionDirectoryInCache;
+ (NSString*)getProvisionPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getIntroDirectoryInCache;
+ (NSString*)getIntroPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getDmDirectoryInCache;
+ (NSString*)getDmPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getClassDirectoryInCache;
+ (NSString*)getClassPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext;
+ (NSString*)getCatalogDirectoryInCache;
+ (NSString*)getCatalogPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext;
@end
