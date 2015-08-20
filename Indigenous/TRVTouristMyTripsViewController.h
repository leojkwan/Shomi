//
//  TRVTouristMyTripsViewController.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRVUser;

@interface TRVTouristMyTripsViewController : UIViewController

@property (nonatomic, strong) TRVUser *tourist;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addTourButton;


@end
