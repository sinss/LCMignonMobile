//
//  downloadStoreDelegate.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "downloadStoreDelegate.h"
#import "globalFunction.h"

@interface downloadStoreDelegate()

- (void)parseCSVData;
- (void)checkAppConfigKey:(NSString*)key andValue:(NSString*)value;
- (void)checkAppDateKey:(NSString*)key andValue:(NSString*)value;

@end

@implementation downloadStoreDelegate
@synthesize delegate;
@synthesize currLocation;
@synthesize csvLoadtype;

- (id)initWithURL:(NSString*)url
{
    self = [super init];
    if (self)
    {
        postUrl = [[NSURL alloc] initWithString:url];
        if (currentRow == nil)
        {
            currentRow = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return self;
}

- (void)dealloc
{
    [currLocation release], currLocation = nil;
    [postUrl release], postUrl = nil;
    delegate = nil;
    [super dealloc];
}

- (void)startGetStoreWithRefreshing:(BOOL)ind
{
    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:postUrl
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:120];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    NSLog(@"postUrl:%@",postUrl);
    if (connection)
    {
        responseData = [NSMutableData new];
    }
    */
    [currentRow removeAllObjects];
    isRefreshing = ind;
    [self parseCSVData];
}
- (void)parseCSVData
{
    NSString *fileName = nil;
    NSData *dataDoc = nil;
    BOOL saveInd = YES;
    if (csvLoadtype == csvLoadtypeConfig)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvConfigFile], [globalFunction getTodayString]];
    }
    else if (csvLoadtype == csvLoadtypeDayURL)
    {
        fileName = [NSString stringWithFormat:@"%@_%@", [globalFunction getCacheDirectoryFileNameWithName:csvDayFile], [globalFunction getTodayString]];
    }
    /*
     表示為重新整理
     */
    if (!isRefreshing)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            NSLog(@"%@ exist",fileName);
            dataDoc = [[NSData alloc] initWithContentsOfFile:fileName];
            /*
             如果檔案為空白，則重新自網路取得
             */
            if ([dataDoc length] == 0)
            {
                dataDoc = [[NSData alloc] initWithContentsOfURL:postUrl];
            }
        }
        else
        {
            /*
             表示過了一天，清除前一天的資料
             */
            NSString *cachePath = [globalFunction getCacheDirectory];
            NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[globalFunction getCacheDirectory] error:nil];
            for (NSString *file in files)
            {
                if ([[file pathExtension] isEqualToString:@"csv"])
                {
                    NSString *delegatePath = [cachePath stringByAppendingPathComponent:file];
                    [[NSFileManager defaultManager] removeItemAtPath:delegatePath error:nil];
                }
            }
            NSLog(@"%@ notexist", fileName);
            dataDoc = [[NSData alloc] initWithContentsOfURL:postUrl];
        }
    }
    else
    {
        dataDoc = [[NSData alloc] initWithContentsOfURL:postUrl];
    }
    
    NSString *csvData = [[NSString alloc] initWithData:dataDoc encoding:NSUTF8StringEncoding];
    /*
     設定為只讀取店家列表
     */
    CHCSVParser *p = [(CHCSVParser *)[CHCSVParser alloc] initWithCSVString:csvData encoding:NSUTF8StringEncoding error:nil];
    [p setParserDelegate:self];
    [p parse];
    if (csvLoadtype == csvLoadtypeStore)
    {
        /*
         排序
         */
        /*
        NSArray *sortArray = [storeArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSNumber *first = [NSNumber numberWithInt:[(StoreTemp*)a Distance]];
            NSNumber *second = [NSNumber numberWithInt:[(StoreTemp*)b Distance]];
            return [first compare:second];
        }];
        [delegate downloadDelegate:self didFinishDownloadWithData:sortArray];
         */
    }
    NSError *error = nil;
    if (saveInd)
    {
        //判斷是否需要儲存
        BOOL saveInd = [csvData writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (!saveInd)
        {
            NSLog(@"save:%@ with rror:%@", fileName, error);
        }
    }
    [p release];
    [csvData release];
    [dataDoc release];
}

#pragma mark - NSURLconnection delegate
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    [responseData release], responseData = nil;
    [delegate downloadDelegate:self didFaildDownloadWithError:@"下載失敗"];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseCSVData];
    NSLog(@"did finish download data with %i",responseData.length);
    [responseData release], responseData = nil;
}

#pragma mark CHCSVParserDelegate methods

- (void) parser:(CHCSVParser *)parser didStartDocument:(NSString *)csvFile
{
    // NSLog(@"Tab_%@_Parser!",csvFile);
    switch (csvLoadtype)
    {
        case csvLoadtypeStore:
            //[storeArray removeAllObjects];
            break;
    }
}

- (void) parser:(CHCSVParser *)parser didStartLine:(NSUInteger)lineNumber
{
    //   NSLog(@"%d.Psr.startLine!",lineNumber);
    
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber
{
    if(lineNumber > 1)
    {
        switch (csvLoadtype)
        {
            case csvLoadtypeConfig:
                if ([currentRow count] == 3)
                {
                    [self checkAppConfigKey:[currentRow objectAtIndex:0] andValue:[currentRow objectAtIndex:1]];
                    
                }
                break;
            case csvLoadtypeDayURL:
                if ([currentRow count] == 5)
                {
                    [self checkAppDateKey:[currentRow objectAtIndex:0] andValue:[currentRow objectAtIndex:1]];
                }
                break;
            case csvLoadtypeStore:
                //                NSLog(@"%d-%d.count:%d/",csvLoadtype, lineNumber,  currentRow.count);
                if (currentRow.count == 30)
                {
                    if ([@"Y" compare:[currentRow objectAtIndex:29]] == 0 )
                    {
                        /*
                        StoreTemp *StoreA = [[StoreTemp alloc] init];
                        StoreA.StoreID = [currentRow objectAtIndex:0];
                        StoreA.StoreType  = [currentRow objectAtIndex:1];
                        StoreA.slyPush = [currentRow objectAtIndex:2];
                        StoreA.slyRanking  = [currentRow objectAtIndex:3];
                        StoreA.StoreName = [currentRow objectAtIndex:4];
                        StoreA.StoreAddress  = [currentRow objectAtIndex:5];
                        StoreA.StoreTel  = [currentRow objectAtIndex:6];
                        StoreA.MapX = [currentRow objectAtIndex:7];
                        StoreA.MapY = [currentRow objectAtIndex:8];
                        StoreA.PicA = [currentRow objectAtIndex:9];
                        StoreA.PicB  = [currentRow objectAtIndex:10];
                        StoreA.StoreNews = [currentRow objectAtIndex:11];
                        StoreA.StoreNewsDate  = [currentRow objectAtIndex:12];
                        StoreA.StoreP1 = [currentRow objectAtIndex:13];
                        StoreA.StoreP1URL  = [currentRow objectAtIndex:14];
                        StoreA.StoreP2 = [currentRow objectAtIndex:15];
                        StoreA.StoreP2URL  = [currentRow objectAtIndex:16];
                        StoreA.StoreP3 = [currentRow objectAtIndex:17];
                        StoreA.StoreP3URL  = [currentRow objectAtIndex:18];
                        StoreA.StoreP4 = [currentRow objectAtIndex:19];
                        StoreA.StoreP4URL  = [currentRow objectAtIndex:20];
                        StoreA.MovTicket = [currentRow objectAtIndex:21];
                        StoreA.MovTicketDate  = [currentRow objectAtIndex:22];
                        StoreA.slyCardSrv = [currentRow objectAtIndex:23];
                        StoreA.slyCardSrvDate  = [currentRow objectAtIndex:24];
                        StoreA.StoreHR = [currentRow objectAtIndex:25];
                        StoreA.StoreHRContent  = [currentRow objectAtIndex:26];
                        StoreA.StoreHRDate = [currentRow objectAtIndex:27];
                        StoreA.FBURL = [currentRow objectAtIndex:28];
                        StoreA.Enable = [currentRow objectAtIndex:29];
                        CLLocation *distanceLocation = [[[CLLocation alloc] initWithLatitude:[StoreA.MapX doubleValue] longitude:[StoreA.MapY doubleValue]] autorelease] ;
                        CLLocationDistance distance = [currLocation distanceFromLocation:distanceLocation];
                        NSString *distanceString = [[[NSString alloc] initWithFormat:@"%.0f",distance] autorelease] ;
                        
                        StoreA.Distance = [distanceString integerValue] ;
                        
                        [storeArray addObject:StoreA];
                        [StoreA release];
                         */
                    }
                }
                break;
        }
    }
    [currentRow removeAllObjects];
}

- (void) parser:(CHCSVParser *)parser didReadField:(NSString *)field {
    //NSLog(@"Parser didReadField!");
    [currentRow addObject:field];
}

- (void) parser:(CHCSVParser *)parser didEndDocument:(NSString *)csvFile
{
    NSLog(@"csvFile:%@",csvFile);
    
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Psr.failWithError!");
    [delegate downloadDelegate:self didFaildDownloadWithError:@"解析檔案失敗"];
    
}


#pragma mark - 判斷appconfig檔中的值
- (void)checkAppConfigKey:(NSString*)key andValue:(NSString*)value
{
    if ([key isEqualToString:@"DAY_URL"])
    {
        [[appConfigRecord appConfigInstance] setDayURL:value];
    }
    else if ([key isEqualToString:@"TAB_URL1"])
    {
        [[appConfigRecord appConfigInstance] setTabURL1:value];
    }
    else if ([key isEqualToString:@"TAB_URL2"])
    {
        [[appConfigRecord appConfigInstance] setTabURL2:value];
    }
    else if ([key isEqualToString:@"TAB_URL3"])
    {
        [[appConfigRecord appConfigInstance] setTabURL3:value];
    }
    else if ([key isEqualToString:@"TAB_URL4"])
    {
        [[appConfigRecord appConfigInstance] setTabURL4:value];
    }
    else if ([key isEqualToString:@"TAB_URL5"])
    {
        //https://docs.google.com/spreadsheet/pub?key=0Ai_zNVD47hEJdFhsb1dKdWJQeDlpYmc1OVVVODZIVGc&single=true&gid=0&output=csv
        [[appConfigRecord appConfigInstance] setTabURL5:value];
    }
    else if ([key isEqualToString:@"LOC_CENTER_X"])
    {
        [[appConfigRecord appConfigInstance] setLatitude:[NSNumber numberWithDouble:[value doubleValue]]];
    }
    else if ([key isEqualToString:@"LOC_CENTER_Y"])
    {
        [[appConfigRecord appConfigInstance] setLongitude:[NSNumber numberWithDouble:[value doubleValue]]];
    }
    else if ([key isEqualToString:@"TAB_TITLE1"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle1:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE2"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle2:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE3"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle3:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE4"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle4:value];
    }
    else if ([key isEqualToString:@"TAB_TITLE5"])
    {
        [[appConfigRecord appConfigInstance] setTabTitle5:value];
    }
}

- (void)checkAppDateKey:(NSString*)key andValue:(NSString*)value
{
    if ([key isEqualToString:@"WELCOME_PAGE"])
    {
        [[appDateRecord appDateInstance] setWelcomePage:value];
    }
    else if ([key isEqualToString:@"LOTTERY_PAGE"])
    {
        [[appDateRecord appDateInstance] setLotteryPage:value];
    }
    else if ([key isEqualToString:@"LOTTERY_SUB_PAGE"])
    {
        [[appDateRecord appDateInstance] setLotterySubPage:value];
    }
    else if ([key isEqualToString:@"WINNER_PAGE"])
    {
        [[appDateRecord appDateInstance] setWinnerPage:value];
    }
}


@end
