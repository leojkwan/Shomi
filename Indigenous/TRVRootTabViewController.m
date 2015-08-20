//
//  TRVRootTabViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/1/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVRootTabViewController.h"


@interface TRVRootTabViewController ()

@end

@implementation TRVRootTabViewController

- (void)viewDidLoad {
    
    // THIS IS THE TOURIST BRANCH
    [super viewDidLoad];
    
    NSArray *tabbarVCs = @[[[UIStoryboard storyboardWithName:@"MyTripsStoryboard" bundle:nil] instantiateInitialViewController],
                              [[UIStoryboard storyboardWithName:@"SearchTrips" bundle:nil] instantiateInitialViewController],
                           [[UIStoryboard storyboardWithName:@"Profile" bundle:nil] instantiateInitialViewController]];
    self.viewControllers = tabbarVCs;
    self.selectedIndex = 1;
    
    
    UITabBarItem *myTripsTab = [[UITabBarItem alloc] initWithTitle:@"My Trips" image:[UIImage imageNamed:@"myTrips"] selectedImage:[UIImage imageNamed:@"myTrips"]];
    UITabBarItem *findToursTab = [[UITabBarItem alloc] initWithTitle:@"Find Trip" image:[UIImage imageNamed:@"findTrip"] selectedImage:[UIImage imageNamed:@"findTrip"]];
    UITabBarItem *profileTab = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profileTab"] selectedImage:[UIImage imageNamed:@"profileTab"]];
    
    
    UIViewController *firstVC = self.viewControllers[0];
    UIViewController *secondVC = self.viewControllers[1];
    UIViewController *thirdVC = self.viewControllers[2];
    firstVC.tabBarItem = myTripsTab;
    secondVC.tabBarItem = findToursTab;
    thirdVC.tabBarItem = profileTab;

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
