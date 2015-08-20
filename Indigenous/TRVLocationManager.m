//
//  TRVLocationManager.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/13/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));

#import "TRVLocationManager.h"
#import "TRVTourStop.h"
    //TODO:[Amitai] if there's no wifi, lower the required accuracy of location calls

static TRVLocationManager *_sharedLocationManager;

@interface TRVLocationManager ()
@property (nonatomic, strong) NSMutableArray *completionBlocks;
@end

@implementation TRVLocationManager

    //Thank you snippets!
+ (TRVLocationManager *)sharedLocationManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationManager = [TRVLocationManager new];
    });
    
    return _sharedLocationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
            //!!!code goes here...
    }
    return self;
}

#pragma mark -
    //"get" means "retrieve from the array" not "query a server or something" [confirm!!!]
-(void)getLocationWithCompletionBlock:(TRVLocationUpdateCompletionBlock)block {
    if (block) {
        [self.completionBlocks addObject:[block copy]]; //So we don't lose any requests, but check to prevent an exception/skip the process.
    } else {
        DBLG //a flag - "nothing to see here"
    }
    
    if (self.hasLocation) {
        for (TRVLocationUpdateCompletionBlock completionBlock in self.completionBlocks) {
            completionBlock(self.location, nil);
        }
        if ([self.completionBlocks count] == 0) {
                //notify mapView of change to location when not specifically requested by us/our app
            [[NSNotificationCenter defaultCenter] postNotificationName:@"locationUpdated" object:nil];
        }
        
        [self.completionBlocks removeAllObjects];
    }
    
    if (self.locationError) {
        for (TRVLocationUpdateCompletionBlock completionBlock in self.completionBlocks) {
            completionBlock(nil, self.locationError);
        }
        [self.completionBlocks removeAllObjects];
    }
}


#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
        //Filter out inaccurate points
    CLLocation *lastLocation = [locations lastObject];
    if (lastLocation.horizontalAccuracy < 0) //A negative value → invalid
    {
        return;
    }
        //Now, let's work with valid locations.
    self.location      = lastLocation;
    self.hasLocation   = YES;
    self.locationError = nil;
    
    [TRVLocationManager logLocationToConsole:lastLocation];
    
    [self getLocationWithCompletionBlock:nil];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
    self.locationError = error;
    [self getLocationWithCompletionBlock:nil];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
//    DENIED
//    ======
    if (status == kCLAuthorizationStatusDenied) {
            //Location services are disabled on the device.
        [self.locationManager stopUpdatingLocation];
        
        NSString *erroMessage = @"Location Services Permission Denied for this app. Visit Settings.app to allow. Like you're really gonna do that. Just go ahead and DELETE ME, the wait is killing me! My motherboard said there'd be days like this...";
        
        NSDictionary *errorInfo = @{NSLocalizedDescriptionKey : erroMessage};
        
        NSError *deniedError = [NSError errorWithDomain:@"TRVLocationErrorDomain"
                                                   code:1
                                               userInfo:errorInfo];
        
        self.locationError = deniedError;
        [self getLocationWithCompletionBlock:nil];
    }
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            //Location services have just been authorized on the device, startupdating now.
        [self.locationManager startUpdatingLocation]; //!!!This is where the magic happens, people!
        self.locationError = nil;
    }
    
}


#pragma mark - helper methods

+ (void)logLocationToConsole:(CLLocation*)location
{
    CLLocationCoordinate2D coord = location.coordinate;
    NSLog(@"Location lat/long: %f,%f",coord.latitude, coord.longitude);
    
    CLLocationAccuracy horizontalAccuracy =
    location.horizontalAccuracy;
    
    NSLog(@"Horizontal accuracy: %f meters",horizontalAccuracy);
    
    CLLocationDistance altitude = location.altitude;
    NSLog(@"Location altitude: %f meters",altitude);
    
    CLLocationAccuracy verticalAccuracy =
    location.verticalAccuracy;
    
    NSLog(@"Vertical accuracy: %f meters",verticalAccuracy);
    
    NSDate *timestamp = location.timestamp;
    NSLog(@"Timestamp: %@",timestamp);
    
    CLLocationSpeed speed = location.speed;
    NSLog(@"Speed: %f meters per second",speed);
    
    CLLocationDirection direction = location.course;
    NSLog(@"Course: %f degrees from true north",direction);

}
/**
 *  Requests the desired type of authorization. iOS 7-'s kCLAuthorizationStatusAuthorized (deprecated) = 3, 
 *  same as the new kCLAuthorizationStatusAuthorizedAlways - no checking needed. Optionally redirects user to
 *  Settings via AlertController if a presenting viewcontroller is passed (otherwise, pass nil).
 *
 *  @param desiredAuthorizationStatus Desired status of type CLA
 *  @param vc                         A view controller to present the UIAlert
 */
- (void)conditionalRequestForAuthorizationOfType:(CLAuthorizationStatus)desiredAuthorizationStatus inView:(UIViewController*)vc {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    NSLog(@"CLAuthorization status is %i", status);

    NSString *title;
    NSString *message;
    UIAlertAction *changeSettings;
    
        if (status == kCLAuthorizationStatusDenied ||
            status == kCLAuthorizationStatusRestricted) {
            title =  @"Location Services Are Off";;
            message = @"Go to settings to enable Location Services, cutie 😉";
            changeSettings = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication]openURL:settingsURL];
            }];
        } else if (status == kCLAuthorizationStatusNotDetermined) {
            title = @"Background use is not enabled";
            message = @"Enable webca--I mean Location Services for not-spying purposes.";
            changeSettings = [UIAlertAction actionWithTitle:@"Enable" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                switch (desiredAuthorizationStatus) {
                    case kCLAuthorizationStatusAuthorizedAlways:
                        [self.locationManager requestAlwaysAuthorization];
                        break;
                    case kCLAuthorizationStatusAuthorizedWhenInUse:
                        [self.locationManager requestWhenInUseAuthorization];
                        break;
                    default:
                        NSLog(@"What kind of status did you REQUEST? It's not where you are, but where you wanna go...");
                        break;
                }
            }];
            
            UIAlertController *settingsAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [settingsAlert addAction:changeSettings];
            [settingsAlert addAction:cancel];
            
                //skip if "nil" is passed
            if (vc) {
                [vc presentViewController:settingsAlert animated:YES completion:nil];
            }
        }
}




/**
 *  Region Monitoring delegate methods - for when we implement the Tour Guide Tools...
 *
 */
//#pragma mark - Region Monitoring delegate methods
//
//- (void)locationManager:(CLLocationManager *)manager
//         didEnterRegion:(CLRegion *)region
//{
//    NSString *placeIdentifier = [region identifier];
//    NSURL *placeIDURL = [NSURL URLWithString:placeIdentifier];
//    
//    NSManagedObjectID *placeObjectID =
//    [kAppDelegate.persistentStoreCoordinator
//     managedObjectIDForURIRepresentation:placeIDURL];
//    
//    [kAppDelegate.managedObjectContext performBlock:^{
//        
//        ICFFavoritePlace *place =
//        (ICFFavoritePlace *)[kAppDelegate.managedObjectContext
//                             objectWithID:placeObjectID];
//        
//        NSNumber *distance = [place valueForKey:@"displayRadius"];
//        NSString *placeName = [place valueForKey:@"placeName"];
//        
//        NSString *baseMessage =
//        @"Favorite Place %@ nearby - within %@ meters.";
//        
//        NSString *proximityMessage =
//        [NSString stringWithFormat:baseMessage,placeName,distance];
//        
//        UIAlertView *alert =
//        [[UIAlertView alloc] initWithTitle:@"Favorite Nearby!"
//                                   message:proximityMessage
//                                  delegate:nil
//                         cancelButtonTitle:@"OK"
//                         otherButtonTitles: nil];
//        [alert show];
//    }];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
//{
//    NSString *placeIdentifier = [region identifier];
//    NSURL *placeIDURL = [NSURL URLWithString:placeIdentifier];
//    
//    NSManagedObjectID *placeObjectID =
//    [kAppDelegate.persistentStoreCoordinator
//     managedObjectIDForURIRepresentation:placeIDURL];
//    
//    [kAppDelegate.managedObjectContext performBlock:^{
//        
//        ICFFavoritePlace *place =
//        (ICFFavoritePlace *)[kAppDelegate.managedObjectContext
//                             objectWithID:placeObjectID];
//        
//        NSNumber *distance = [place valueForKey:@"displayRadius"];
//        NSString *placeName = [place valueForKey:@"placeName"];
//        
//        NSString *baseMessage =
//        @"Favorite Place %@ Geofence exited.";
//        
//        NSString *proximityMessage =
//        [NSString stringWithFormat:baseMessage,placeName,distance];
//        
//        UIAlertView *alert =
//        [[UIAlertView alloc] initWithTitle:@"Geofence exited"
//                                   message:proximityMessage
//                                  delegate:nil
//                         cancelButtonTitle:@"OK"
//                         otherButtonTitles: nil];
//        [alert show];
//    }];
//    
//}
//
//- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
//{
//    
//}


@end
