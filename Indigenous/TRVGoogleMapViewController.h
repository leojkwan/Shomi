//
//  TRVPickerMapViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

    //???:AMITAI redundant now that we need CoreLocation.h for the initialLocation...
//@class CLLocation;

@protocol TRVPickerMapDelegate <NSObject>

-(void)userSelectedTourStopLocation:(CLLocation*)location;

@end


@interface TRVGoogleMapViewController : UIViewController

@property (nonatomic, strong) id<TRVPickerMapDelegate> delegate;

@end
