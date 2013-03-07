//
//  appConfigRecord.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/10.
//
//

#import "appConfigRecord.h"

appConfigRecord *appConfigInstance;

@implementation appConfigRecord
@synthesize dayURL, tabURL1, tabURL2, tabURL3, tabURL4, tabURL5;
@synthesize tabTitle1, tabTitle2, tabTitle3, tabTitle4, tabTitle5;
@synthesize currentAddress, currentLocation, categoryURL, latitude, longitude;

+ (appConfigRecord*)appConfigInstance
{
    if (appConfigInstance == nil)
    {
        appConfigInstance = [[appConfigRecord alloc] init];
    }
    return appConfigInstance;
}

- (void)dealloc
{
    [dayURL release], dayURL = nil;
    [tabURL1 release], tabURL1 = nil;
    [tabURL2 release], tabURL2 = nil;
    [tabURL3 release], tabURL3 = nil;
    [tabURL4 release], tabURL4 = nil;
    [tabURL5 release], tabURL5 = nil;
    [tabTitle1 release], tabTitle1 = nil;
    [tabTitle2 release], tabTitle2 = nil;
    [tabTitle3 release], tabTitle3 = nil;
    [tabTitle4 release], tabTitle4 = nil;
    [tabTitle5 release], tabTitle5 = nil;
    [currentAddress release], currentAddress = nil;
    [currentLocation release], currentLocation = nil;
    [categoryURL release], categoryURL = nil;
    [longitude release], longitude = nil;
    [latitude release], latitude = nil;
    [super dealloc];
}

@end
