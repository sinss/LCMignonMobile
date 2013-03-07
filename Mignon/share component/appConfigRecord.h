//
//  appConfigRecord.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/10.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface appConfigRecord : NSObject
{
    NSString *dayURL;
    NSString *tabURL1;
    NSString *tabURL2;
    NSString *tabURL3;
    NSString *tabURL4;
    NSString *tabURL5;
    NSString *tabTitle1;
    NSString *tabTitle2;
    NSString *tabTitle3;
    NSString *tabTitle4;
    NSString *tabTitle5;
    CLLocation *currentLocation;
    NSMutableString *currentAddress;
    NSString *categoryURL;
    NSNumber *latitude;
    NSNumber *longitude;
}

@property (nonatomic, retain) NSString *dayURL;
@property (nonatomic, retain) NSString *tabURL1;
@property (nonatomic, retain) NSString *tabURL2;
@property (nonatomic, retain) NSString *tabURL3;
@property (nonatomic, retain) NSString *tabURL4;
@property (nonatomic, retain) NSString *tabURL5;
@property (nonatomic, retain) NSString *tabTitle1;
@property (nonatomic, retain) NSString *tabTitle2;
@property (nonatomic, retain) NSString *tabTitle3;
@property (nonatomic, retain) NSString *tabTitle4;
@property (nonatomic, retain) NSString *tabTitle5;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) NSMutableString *currentAddress;
@property (nonatomic, retain) NSString *categoryURL;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;


+(appConfigRecord*)appConfigInstance;

@end
