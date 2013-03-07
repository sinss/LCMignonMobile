//
//  AddressAnnotation.m
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/18.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import "AddressAnnotation.h"


@implementation AddressAnnotation

@synthesize coordinate,mTitle,mSubTitle,mTag,mPinType;

- (NSString *)subtitle{
	return mSubTitle;
}
- (NSString *)title{
	return mTitle;
}


-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end
