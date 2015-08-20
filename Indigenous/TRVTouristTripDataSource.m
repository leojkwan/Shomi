//
//  TRVTouristTripDataSource.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTouristTripDataSource.h"
#import "TRVTour.h"
#import "TRVTouristTripTableViewCell.h"

@interface TRVTouristTripDataSource ()

@property (nonatomic, weak) NSArray *trips;
@property (nonatomic, copy) void (^configureCell)();

@end

@implementation TRVTouristTripDataSource {
    NSArray *_pastTrips;
    NSArray *_futureTrips;
    BOOL     _past;
}

-(instancetype)initWithTrips:(NSArray *)trips configuration:(void (^)())configureCell {
    if (self = [super init]) {
        _trips = trips;
        _pastTrips = [self pastTrips];
        _futureTrips = [self futureTrips];
        _configureCell = configureCell;
        _past = NO;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (_past)
        return [_pastTrips count];
    return [_futureTrips count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    TRVTour *tourForCell = nil;
    if (_past)
        tourForCell = _pastTrips[indexPath.row];
    else
        tourForCell = _futureTrips[indexPath.row];
    TRVTouristTripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];
    cell.tour = tourForCell;
    //cell.textLabel.text = tourForCell.tourItinerary.name;
    return cell;
}

- (void) changeTripsDisplayed {
    _past = !_past;
}



- (NSArray*)filterTripsWithKey:(NSString*)key comparisonResult:(NSComparisonResult)comparisonResult {
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//        NSComparisonResult result = [[evaluatedObject valueForKey:key] compare:[NSDate date]];
//        NSLog(@"%ld", (long)result);
//        //return YES;
        return [[evaluatedObject valueForKey:key] compare:[NSDate date]] == comparisonResult;
    }];
    return [self.trips filteredArrayUsingPredicate:pred];
}

-(NSArray*)pastTrips {
    return [self filterTripsWithKey:@"tourDeparture" comparisonResult:NSOrderedAscending];
}

- (NSArray*)futureTrips {
    return [self filterTripsWithKey:@"tourDeparture" comparisonResult:NSOrderedDescending];
}

@end
