//
//  AddressAnnotation.h
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/18.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString    *mTitle;
	NSString    *mSubTitle;
    NSInteger   mTag;
    NSInteger   mPinType;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mSubTitle;
@property (nonatomic, assign) NSInteger mTag;
@property (nonatomic, assign) NSInteger mPinType;
@end
