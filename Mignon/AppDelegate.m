//
//  AppDelegate.m
//  Mignon
//
//  Created by sinss on 13/3/7.
//  Copyright (c) 2013年 MountainStar. All rights reserved.
//

#import "AppDelegate.h"
#import "MSNavigationPaneViewController.h"
#import "MSMasterViewController.h"
#import "BrowserViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [_navigationPaneViewController release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [[UINavigationBar appearance] setTintColor:navigationBarColor];
    //[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:navigationBarColor];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      //[UIColor colorWithRed:0.0f/255.0f green:50.0f/255.0f blue:201.0f/255.0f alpha:1],
      [UIColor whiteColor],
      UITextAttributeTextColor,
      [UIColor clearColor],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Helvetica-Bold" size:15.0],
      UITextAttributeFont,
      nil]];

    [[UIToolbar appearance] setTintColor:navigationBarColor];
    launchView = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
    [self.window addSubview:launchView.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[self GetLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Mignon" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Mignon.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void) targetMethod
{
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(tabBarMethod:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)tabBarMethod:(NSTimer*)thetimer
{
    [launchView.view removeFromSuperview];
    [launchView release];
    
    self.navigationPaneViewController = [[MSNavigationPaneViewController alloc] init];
    
    MSMasterViewController *masterViewController = [[MSMasterViewController alloc] init];
    masterViewController.navigationPaneViewController = self.navigationPaneViewController;
    
    self.navigationPaneViewController.masterViewController = masterViewController;
    
    [masterViewController transitionToViewController:MignonViewControllerTypeNews];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationPaneViewController;
    
    [self.window makeKeyAndVisible];
}

#pragma mark 取得位址
- (void)GetLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1.0f;
    [locationManager startUpdatingLocation];
    locationManager.headingFilter = kCLHeadingFilterNone;
    [locationManager startUpdatingHeading];
    
    if ((int)locationManager.location.coordinate.latitude > 0)
    {
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]||
            [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"])
        {
            currentLocation =[[CLLocation alloc] initWithLatitude:25.085f longitude:121.524f];
        }
        else
        {
            currentLocation = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude] ;
        }
    }
    else
    {
        currentLocation =[[CLLocation alloc] initWithLatitude:25.085f longitude:121.524f];
    }
    
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=false",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]];
    NSData *locationData = [[[NSData alloc] initWithContentsOfURL:urlString] autorelease] ;
    
    NSError *error;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:locationData options:NSJSONReadingMutableContainers error:&error];
    
    //如果GPS有查到相對位置
	if (results)
    {
        if ([[results valueForKey:@"status"] isEqualToString:@"OK"])
        {
            NSString *addrA = [[[[[results valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"] stringByReplacingOccurrencesOfString:@"台灣" withString:@""]  substringFromIndex:3]  ;
            
            NSString *lat = [[[[[results valueForKey:@"results"] objectAtIndex:0] valueForKey:@"geometry"]  valueForKey:@"location"] valueForKey:@"lat"];
            
            NSString *lng = [[[[[results valueForKey:@"results"] objectAtIndex:0] valueForKey:@"geometry"]  valueForKey:@"location"] valueForKey:@"lng"];
            //            NSString *addrC = (addrB) ? [NSString stringWithFormat:@"%@號",addrB]:addrB;
            //            [CurrAddr setString:@"%@",addrA];
            
            //            addrA = @"台北市士林區承德路四段186號";
            [currentAddress setString:@""];
            [currentAddress appendFormat:@"%@ 附近",addrA];
            currLat = [lat doubleValue];
            currLng = [lng doubleValue];
            //            NSLog(@"%@",responseString);
            
            NSLog(@"lat=%f lng=%f Address=%@",currLat, currLng, currentAddress);
            //            NSLog(@"lat=%f lng=%f",currLat, currLng);
            currentLocation = [[CLLocation alloc] initWithLatitude:currLat longitude:currLng];
         
            [[appConfigRecord appConfigInstance] setCurrentLocation:currentLocation];
            [[appConfigRecord appConfigInstance] setCurrentAddress:currentAddress];
        }
	}
}

@end
