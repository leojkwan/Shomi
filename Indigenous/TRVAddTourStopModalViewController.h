//
//  TRVAddTourStopModalViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TRVTourStop.h"
#import "TRVItinerary.h"

@interface TRVAddTourStopModalViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *mapLocations;
@property (strong, nonatomic) TRVItinerary *growingItinerary;

- (void)goBack:(id)sender; //so we can dismiss this controller...

@end
