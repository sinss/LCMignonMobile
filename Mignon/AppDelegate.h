//
//  AppDelegate.h
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LaunchViewController.h"

@class MSNavigationPaneViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSMutableString *currentAddress;
    double currLat;
    double currLng;
    
    LaunchViewController *launchView;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSNavigationPaneViewController *navigationPaneViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) targetMethod;
- (void)GetLocation;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
