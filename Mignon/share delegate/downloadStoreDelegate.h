//
//  downloadStoreDelegate.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <iAD/iAD.h>
#import "CHCSVParser.h"
#import "constants.h"
#import "globalFunction.h"
#import "appConfigRecord.h"
#import "appDateRecord.h"

enum
{
    csvLoadtypeConfig = -1,
    csvLoadtypeDayURL = 0,
    csvLoadtypeStore = 1,
    csvLoadtypeTopic = 2,
    csvLoadtypeBrand = 3,
    csvloadtypeMore = 5,
    csvloadtypeCardAuthorize = 6,
    csvloadtypeAdUrl = 7,
    csvLoadTypeActivity = 8,
    csvLoadTypeStage = 9,
    csvLoadTypeDraw = 10,
    csvLoadTypeMovie = 11,
    csvLoadTypeCarnival = 12,
    csvLoadTypePccuNews = 13,
    csvLoadTypePccuCards = 14,
    csvLoadTypePccuMedia = 15,
    csvLoadTypePccuOther = 16,
};
typedef NSUInteger csvLoadType;
@class downloadStoreDelegate;

@protocol downloadStoreListProcess <NSObject>

- (void)downloadDelegate:(downloadStoreDelegate*)obj didFinishDownloadWithData:(NSArray*)storeArray;
- (void)downloadDelegate:(downloadStoreDelegate*)obj didFaildDownloadWithError:(NSString*)errorMessage;

@end

@interface downloadStoreDelegate : NSObject <CHCSVParserDelegate>
{
    id<downloadStoreListProcess> delegate;
    NSURL *postUrl;
    NSMutableData *responseData;
    NSURLConnection *connection;
    csvLoadType csvLoadtype;
    /*
     parse store
     */
    NSMutableArray *currentRow;
    CLLocation *currLocation;
    BOOL isRefreshing;
}
@property (assign) id<downloadStoreListProcess> delegate;
@property (assign) csvLoadType csvLoadtype;
@property (nonatomic, retain) CLLocation *currLocation;

- (id)initWithURL:(NSString*)url;

- (void)startGetStoreWithRefreshing:(BOOL)isRefreshing;

@end
