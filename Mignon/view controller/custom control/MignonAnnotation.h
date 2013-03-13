//
//  MignonAnnotation.h
//  Mignon
//
//  Created by sinss on 13/3/13.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MignonAnnotation : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
