//
//  TRVRootGuideTabBarController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/8/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVRootGuideTabBarController.h"

//Pre-load current location in the background.
#import <INTULocationManager.h>
//#import "INTULocationManager+CurrentLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface TRVRootGuideTabBarController ()

@end

@implementation TRVRootGuideTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    INTULocationManager *locationManager = [INTULocationManager sharedInstance];
    
    [locationManager requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood timeout:10 delayUntilAuthorized:NO block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        NSLog(@"Inside the pre-loading location block. We have %@ succeeded!", (status == INTULocationStatusSuccess) ? @"INDEED" : @"NOT");
    }];
    
    
    NSArray *tabbarVCs = @[[[UIStoryboard storyboardWithName:@"MyTripsStoryboard" bundle:nil] instantiateInitialViewController],
                           [[UIStoryboard storyboardWithName:@"TourGuideFlow" bundle:nil] instantiateInitialViewController],
                           [[UIStoryboard storyboardWithName:@"Profile" bundle:nil] instantiateInitialViewController]];
    
    
    self.viewControllers = tabbarVCs;
    self.selectedIndex = 1;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    NSLog(@"didUpdateLocations, manager: %@, locations: %@", [manager description], [locations description]);
}



@end
