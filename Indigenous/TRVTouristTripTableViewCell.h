//
//  TRVTouristTripTableViewCell.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTourView.h"
#import "TRVMyToursView.h"

@class TRVTour;

@interface TRVTouristTripTableViewCell : UITableViewCell

@property (nonatomic, strong) TRVTour *tour;
@property (weak, nonatomic) IBOutlet TRVMyToursView *TourNib2;

@end
