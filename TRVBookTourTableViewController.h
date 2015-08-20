//
//  TRVBookTourTableViewController.h
//  Indigenous
//
//  Created by Leo Kwan on 8/13/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTour.h"

@interface TRVBookTourTableViewController : UITableViewController

@property (nonatomic, strong) TRVTour *destinationTour;
@property (nonatomic, strong) PFObject *destinationPFTour;


@end
