//
//  TRVTouristTripDataSource.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRVTouristTripDataSource : NSObject <UITableViewDataSource>

-(instancetype)initWithTrips:(NSArray*)trips configuration:(void (^)())configureCell;

- (void) changeTripsDisplayed;

@end
