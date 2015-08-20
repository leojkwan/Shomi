//
//  TRVTouristTripDetailViewController.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse.h>

@class TRVTour, TRVTourStop;

@interface TRVTouristTripDetailViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) TRVTour *tour;
@property (nonatomic, strong) PFObject *PFTour;
@property (weak, nonatomic) IBOutlet UIView *contentView;

-(void)isTourGuideTripViewController;
@end
