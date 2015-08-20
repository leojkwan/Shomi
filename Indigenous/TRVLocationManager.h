//
//  TRVLocationManager.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/13/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved. Which are no rights, because this is taken from Richter and Keeley (c) 2013, "ICF"
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

    //This lets us change the block-syntax into s/t more familiar...
typedef void (^TRVLocationUpdateCompletionBlock)(CLLocation *location, NSError *error);

@interface TRVLocationManager : NSObject <CLLocationManagerDelegate>

+ (TRVLocationManager *)sharedLocationManager;
+ (void)logLocationToConsole:(CLLocation*)location;

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) BOOL hasLocation;
@property (nonatomic, strong) NSError *locationError;
@property (nonatomic, strong) CLGeocoder *geocoder;

- (void)getLocationWithCompletionBlock:(TRVLocationUpdateCompletionBlock)block;
- (void)conditionalRequestForAuthorizationOfType:(CLAuthorizationStatus)desiredAuthorizationStatus inView:(UIViewController*)vc;

@end
