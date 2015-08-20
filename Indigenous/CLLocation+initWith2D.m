//
//  CLLocation+initWith2D.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "CLLocation+initWith2D.h"

@implementation CLLocation (initWith2D)

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    return [self initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

@end
