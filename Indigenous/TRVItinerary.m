//
//  TRVItinerary.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVItinerary.h"

@implementation TRVItinerary

-(instancetype)initNameOfTour:(NSString *)name tourImage:(UIImage *)tourImage tourStops:(NSMutableArray *)tourStops {

    self = [super init];
    
    if (self) {
        _nameOfTour = name;
        _tourImage = tourImage;
        _tourStops = tourStops;
        _numberOfStops = tourStops.count;
    }
    
    return self;
}
    //Added under the advice of the TA's...
-(instancetype)init {
    return [self initNameOfTour:@""
                      tourImage:[UIImage imageNamed:@"button_my_location"]
                      tourStops:[NSMutableArray new]];
}




@end
