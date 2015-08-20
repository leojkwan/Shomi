//
//  AppDelegate.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import "TRVConstants.h"
#import <Parse.h>
#import <AFNetworkReachabilityManager.h>
#import "TRVLocationManager.h"
#import <HNKGooglePlacesAutocomplete.h>
#import <CoreLocation/CoreLocation.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse enableLocalDatastore];
    
    [Parse setApplicationId:PARSE_APPLICATION_ID
                  clientKey:PARSE_CLIENT_KEY];
//!!![AMITAI]: This is purely for debugging ↓
   // [PFUser enableAutomaticUser];
    
    
    [GMSServices provideAPIKey:GOOGLE_API_KEY];
        //TODO: [Amitai] Check for redundancy:
    [HNKGooglePlacesAutocompleteQuery setupSharedQueryWithAPIKey:GOOGLE_API_KEY];
    
   
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    TRVLocationManager *appLocationManager = [TRVLocationManager sharedLocationManager];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        //If we have "when in use" authorization, this is not necessary.
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        [appLocationManager.locationManager stopUpdatingLocation];
    }
}

//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [FBSDKAppEvents activateApp];
//
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//}

//FACEBOOK LOGIN RELATED
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}



@end
