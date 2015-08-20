//
//  TRVCustomAnnotation.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVCustomAnnotation.h"
#import "CLLocation+initWith2D.h"

@implementation TRVCustomAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
    }
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:coordinate];
    
    NSLog([NSString stringWithFormat:@"Annotation initialized with location: %@", [location description]]);
    return self;
}

-(instancetype)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(0, 0)];
}

@end
