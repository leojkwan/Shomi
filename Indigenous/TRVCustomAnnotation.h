//
//  TRVCustomAnnotation.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TRVCustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
-(instancetype)init;

@end
