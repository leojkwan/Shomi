//
//  TRVDetailGuideAllTripsDataSource.h
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import "NSMutableArray+extraMethods.h"
#import "TRVUser.h"
#import "TRVTourStop.h"


@interface TRVDetailGuideAllTripsDataSource : NSObject <UITableViewDataSource>

- (void) changeTripsDisplayed;

-(instancetype)initWithGuide:(TRVUser*)selectedGuide;

@end
