//
//  TRVTourStop.h
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>

    //To work with MapKit and MKMapViews, tourStops are now MKAnnotations (e.g., map pins)
    //Among other things, this gives them (invisibly) extra properties: title, subtitle, coordinate.
@interface TRVTourStop : NSObject <MKAnnotation>


@property (nonatomic) CGFloat operatorCost;
@property (nonatomic) CGFloat incidentalCost;
@property (nonatomic) CLLocationDegrees lat;
@property (nonatomic) CLLocationDegrees lng;
@property (nonatomic) CLLocationCoordinate2D tourStopLocation;
@property (nonatomic, strong) CLLocation *tourStopCLLocation;
@property (nonatomic, strong) GMSMarker *tourStopMarker;
@property (nonatomic, strong) NSString *nameOfPlace;
@property (nonatomic, strong) NSString *addressOfEvent;
@property (nonatomic, strong) NSString *cityOfEvent;
@property (nonatomic, strong) NSString *descriptionOfEvent;
@property (nonatomic, strong) UIImage *image; // included in GMSMarker but uncommented for testing and to allow user provided images


-(instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates operatorCost:(CGFloat)oCost incidentalCost:(CGFloat)iCost image:(UIImage *)image;

-(instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates;

-initWithLocation:(CLLocation*)location;

-initWithMapMarker:(GMSMarker *)marker;

-(instancetype)initWithAnnotation:(id<MKAnnotation>)originalAnnotation;

@end
