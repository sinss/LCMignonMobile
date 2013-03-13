//
//  MignonAnnotation.m
//  Mignon
//
//  Created by sinss on 13/3/13.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MignonAnnotation.h"

#define kABPersonAddressStreetKey @"kABPersonAddressStreetKey.key"

@interface MignonAnnotation()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;

@end

@implementation MignonAnnotation


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self = [super init]))
    {
        if ([name isKindOfClass:[NSString class]])
        {
            self.name = name;
        } else {
            self.name = @"Unknown charge";
        }
        self.address = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title
{
    return _name;
}

- (NSString *)subtitle
{
    return _address;
}

- (CLLocationCoordinate2D)coordinate
{
    return _theCoordinate;
}

- (MKMapItem*)mapItem
{
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
