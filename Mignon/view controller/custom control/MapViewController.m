//
//  MapViewController.m
//  Mignon
//
//  Created by sinss on 13/3/13.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "MapViewController.h"
#import "appConfigRecord.h"
#import "MignonAnnotation.h"

#define METERS_PER_MILE 1609.344

@interface MapViewController () <MKMapViewDelegate>

- (void)createAnnotations;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [mapView setDelegate:self];
    [self createAnnotations];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[[appConfigRecord appConfigInstance] latitude] doubleValue];
    zoomLocation.longitude= [[[appConfigRecord appConfigInstance] longitude] doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [mapView setRegion:viewRegion animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)amapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MignonAnnotation class]])
    {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [amapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"orange_pin.png"];//here we use a nice image instead of the default pins

        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)createAnnotations
{
    NSNumber * latitude = [[appConfigRecord appConfigInstance] latitude];
    NSNumber * longitude = [[appConfigRecord appConfigInstance] longitude];
    NSString * crimeDescription = @"米格諾~~~yo~~~~";
    NSString * address = [NSString stringWithFormat:@"台北市信義區信義路五段150巷2號6樓"];;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude.doubleValue;
    coordinate.longitude = longitude.doubleValue;
    MignonAnnotation *annotation = [[MignonAnnotation alloc] initWithName:crimeDescription address:address coordinate:coordinate] ;
    [mapView addAnnotation:annotation];
}

@end
