//
//  TRVEvent.m
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStop.h"

@implementation TRVTourStop 


-(instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates
        operatorCost:(CGFloat)oCost
      incidentalCost:(CGFloat)iCost
               image:(UIImage *)image
{
    
    if (self = [super init]) {
        _operatorCost     = oCost;
        _incidentalCost   = iCost;
        _tourStopLocation = coordinates;
        _lat              = coordinates.latitude;
        _lng              = coordinates.longitude;
        _tourStopMarker   = [GMSMarker markerWithPosition:coordinates];
        _nameOfPlace = @"Flatiron School";
        _descriptionOfEvent = @"best school ever";

        _tourStopCLLocation = [[CLLocation alloc] initWithLatitude:_lat longitude:_lng];

    }
    return self;
};

-(instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates {
    return [self initWithCoordinates:coordinates
                        operatorCost:0
                      incidentalCost:0
                               image:[UIImage imageWithCIImage:[CIImage emptyImage]]];
    
}

-(instancetype)initWithMapMarker:(GMSMarker *)marker {
    _tourStopMarker = marker;
    return [self initWithCoordinates:marker.position];
}

-(instancetype)initWithAnnotation:(id<MKAnnotation>)originalAnnotation {
    self.coordinate = originalAnnotation.coordinate;
        //???:[Amitai]Why can't we set these two properties? B/c they're optional?
        //    self.title = originalAnnotation.title;
        //    self.subtitle = originalAnnotation.subtitle;
    
    return [self initWithCoordinates:originalAnnotation.coordinate];
}

-(id)initWithLocation:(CLLocation *)location {
    return [self initWithCoordinates:location.coordinate];
}

@end
