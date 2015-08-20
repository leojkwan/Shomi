//
//  TRVRootGuideTabController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVRootGuideTabController.h"
#import "NSMutableArray+extraMethods.h"

@interface TRVRootGuideTabController ()

@end

@implementation TRVRootGuideTabController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *tabbarVCs = @[[[UIStoryboard storyboardWithName:@"MyTripsStoryboard" bundle:nil] instantiateInitialViewController],
                           [[UIStoryboard storyboardWithName:@"Profile" bundle:nil] instantiateInitialViewController]];
    

    
    self.viewControllers = tabbarVCs;
    self.selectedIndex = 0;
    
    
    UITabBarItem *myTripsTab = [[UITabBarItem alloc] initWithTitle:@"My Trips" image:[UIImage imageNamed:@"myTrips"] selectedImage:[UIImage imageNamed:@"myTrips"]];
//    UITabBarItem *makeToursTab = [[UITabBarItem alloc] initWithTitle:@"Create Trip" image:[UIImage imageNamed:@"timeline"] selectedImage:[UIImage imageNamed:@"timeline"]];
    UITabBarItem *profileTab = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profileTab"] selectedImage:[UIImage imageNamed:@"profileTab"]];

    
    UIViewController *firstVC = self.viewControllers[0];
   // UIViewController *secondVC = self.viewControllers[1];
    UIViewController *thirdVC = self.viewControllers[1];
    firstVC.tabBarItem = myTripsTab;
  //  secondVC.tabBarItem = makeToursTab;
    thirdVC.tabBarItem = profileTab;

//    [NSMutableArray createParseDummyTour];
//    [NSMutableArray createParseDummyTour2];
//    [NSMutableArray createParseDummyTour3];

    
}




@end
