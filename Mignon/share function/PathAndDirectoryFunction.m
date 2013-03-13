//
//  PathAndDirectoryFunction.m
//  MLIproposal
//
//  Created by 張星星 on 12/5/19.
//  Copyright (c) 2012年 Mountant Star Software. All rights reserved.
//

#import "PathAndDirectoryFunction.h"

@implementation PathAndDirectoryFunction

#pragma mark - 取得個人資料夾的路徑or檔案路徑
+ (NSString*)getDocumentDirectoryWithAgentCode:(NSString*)agid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    return documentsDirectory;
}
#pragma mark /agent_code/report/    (報表產出區)
+ (NSString*)getReportDriectoryInDocumentWithAgentCode:(NSString*)agid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:reportDirectoryName];
    return documentsDirectory;
}
+ (NSString*)getReportPathInDocumentWithAgentCode:(NSString*)agid andFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:reportDirectoryName];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:file];
    documentsDirectory = [documentsDirectory stringByAppendingPathExtension:ext];
    return documentsDirectory;
}

#pragma mark /agent_code/saveData/   (存檔區)
+ (NSString*)getSavedataDriectoryInDocumentWithAgentCode:(NSString*)agid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:saveDataDirectoryName];
    return documentsDirectory;
}

+ (NSString*)getSavedataPathInDocumentWithAgentCode:(NSString*)agid andFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:saveDataDirectoryName];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:file];
    documentsDirectory = [documentsDirectory stringByAppendingPathExtension:ext];
    return documentsDirectory;
}
#pragma mark /agent_code/info/   (使用者必要資訊儲存)
+ (NSString*)getInfoDriectoryInDocumentWithAgentCode:(NSString*)agid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:infoDirectoryName];
    return documentsDirectory;
}

+ (NSString*)getInfoPathInDocumentWithAgentCode:(NSString*)agid andFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:agid];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:infoDirectoryName];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:file];
    documentsDirectory = [documentsDirectory stringByAppendingPathExtension:ext];
    return documentsDirectory;
}

#pragma mark - 在document資料夾中取得完整路徑
+ (NSString*)getDocumentPathWithFileName:(NSString*)fileName andExtension:(NSString*)ext
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    fullPath = [fullPath stringByAppendingPathExtension:ext];
    return fullPath;
}

#pragma mark - 在 Temperary 資料夾中取得完整路徑
+ (NSString*)getTempPathWithFileName:(NSString*)file andExtension:(NSString*)ext;
{
    NSString *tempDirectory = NSTemporaryDirectory();
    NSString *fullPath = [tempDirectory stringByAppendingPathComponent:file];
    fullPath = [fullPath stringByAppendingPathExtension:ext];
    return fullPath;
}

#pragma mark - 在 Cache 資料夾中取得完整路徑
+ (NSString*)getCachePathWithFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cacheFile = [cachePath stringByAppendingPathComponent:file];
    cacheFile = [cacheFile stringByAppendingPathExtension:ext];
    return cacheFile;
}
#pragma mark /cache/provision/ (條款)
+ (NSString*)getProvisionDirectoryInCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:provisionDirectoryName];
    return cachePath;
}
+ (NSString*)getProvisionPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:provisionDirectoryName];
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:file];
    cacheFilePath = [cacheFilePath stringByAppendingPathExtension:ext];
    return cacheFilePath;
}

#pragma mark /cache/intro/ (商品說明書與其它相關報表)
+ (NSString*)getIntroDirectoryInCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:introDirectoryName];
    return cachePath;
}
+ (NSString*)getIntroPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:introDirectoryName];
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:file];
    cacheFilePath = [cacheFilePath stringByAppendingPathExtension:ext];
    return cacheFilePath;
}

#pragma mark /cache/dm/ (商品dm)
+ (NSString*)getDmDirectoryInCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:dmDirectoryName];
    return cachePath;
}

+ (NSString*)getDmPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:dmDirectoryName];
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:file];
    cacheFilePath = [cacheFilePath stringByAppendingPathExtension:ext];
    return cacheFilePath;
}

#pragma mark /cache/class/ (商品講義)
+ (NSString*)getClassDirectoryInCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:classDirectoryName];
    return cachePath;
}

+ (NSString*)getClassPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:classDirectoryName];
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:file];
    cacheFilePath = [cacheFilePath stringByAppendingPathExtension:ext];
    return cacheFilePath;
}

#pragma mark /cache/catalog/ (商品型錄)
+ (NSString*)getCatalogDirectoryInCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:catalogDirectoryName];
    return cachePath;
}

+ (NSString*)getCatalogPathInCacheWithFileName:(NSString*)file andExtension:(NSString*)ext
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachePath = [cachePath stringByAppendingPathComponent:catalogDirectoryName];
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:file];
    cacheFilePath = [cacheFilePath stringByAppendingPathExtension:ext];
    return cacheFilePath;
}
@end
