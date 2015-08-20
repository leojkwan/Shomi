//
//  CLLocation+initWith2D.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (initWith2D)

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
