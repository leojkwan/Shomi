//
//  NSString+TRVExtraMethods.m
//  Indigenous
//
//  Created by Leo Kwan on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSString+TRVExtraMethods.h"

@implementation NSString (TRVExtraMethods)

+(NSString *)formatDateDepartureForTour:(TRVTour *)tour{
    
    NSDateFormatter *dayAndMonthFormat = [[NSDateFormatter alloc] init];
    
    NSDate *dateForThisTour = tour.tourDeparture;
    
    [dayAndMonthFormat setDateFormat:@"EEE, MMM d"];
    
    NSString *dayAndMonthOfTrip = [dayAndMonthFormat stringFromDate:dateForThisTour];
    
    return dayAndMonthOfTrip;
}


@end
