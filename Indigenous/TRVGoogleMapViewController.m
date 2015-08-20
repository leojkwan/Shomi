//
//  TRVPickerMapViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

//#import "TRVPickerMapLogic.h" //includes GMapsSDK
#import <GoogleMaps/GoogleMaps.h>
#import "TRVAddToursVC.h"
#import "TRVGoogleMapViewController.h"
#import <Parse.h>
#import "CustomInfoWindowView.h"
#import <CoreLocation/CoreLocation.h>
#import "TRVLocationManager.h"
#import <HNKGooglePlacesAutocomplete.h>


@interface TRVGoogleMapViewController () <GMSMapViewDelegate>

//@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, copy) NSSet *markers;

@end

@implementation TRVGoogleMapViewController {
    GMSMapView *mapView_;
    GMSMarker *userSelection_;
    GMSMarker *previousSelection_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
        //FIXME: need a way to dismiss the map.
        //update: Still relevant??

    
    CLLocationCoordinate2D defaultLocation = CLLocationCoordinate2DMake(40, -75);

#pragma mark - MapView Initialization
        //Opens the map to the user's current location.
    GMSCameraPosition *defaultCamera       = [GMSCameraPosition cameraWithTarget:defaultLocation zoom:14];
    mapView_                           = [GMSMapView mapWithFrame:self.view.bounds camera:defaultCamera];
    mapView_.mapType                   = kGMSTypeNormal;
    mapView_.myLocationEnabled         = YES;
    mapView_.settings.compassButton    = YES;
    mapView_.settings.myLocationButton = YES;
    [mapView_ setMinZoom:10 maxZoom:18];
    
//    UITapGestureRecognizer *doubleTap = [UITapGestureRecognizer new];
//    doubleTap.numberOfTapsRequired = 2;
//    
//    [mapView_ addGestureRecognizer:doubleTap];
   
    self.view = mapView_;
    mapView_.delegate = self;

        //Optional: Zoom in once we get a lock-on, actual current location
    
//    TRVLocationManager *locationManager = [TRVLocationManager sharedLocationManager];
//    locationManager getLocationWithCompletionBlock:^(CLLocation *location, NSError *error) {
    /**
     *  I wrote (rewrote) a nice Location Manager singleton...but Parse does the whole deal for you!
     *
     *  @return currentLocation
     */
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (error) {
            NSLog(@"Danger Wil Robinson! Danger (PFGeoPoint couldn't get our current location! Error: %@", error);
        } else {
            CLLocationCoordinate2D currentPosition = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentPosition zoom:15];
            GMSCameraUpdate *update = [GMSCameraUpdate setCamera:camera];
            [mapView_ animateWithCameraUpdate:update];
            NSLog(@"PFGeoPoint says I'm here: %.04f, %.04f", geoPoint.latitude, geoPoint.longitude);
        }
    }];
}



    //Only draw markers that are not already On...
-(void)drawMarkers {
    for (GMSMarker *marker in self.markers) {
        if (marker.map == nil) {
            marker.map = mapView_;
        }
    }
}


-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
        //This will ensure the compass and myLocation button are not covered up by the NavigationBar etc.
    mapView_.padding = UIEdgeInsetsMake(self.topLayoutGuide.length    + 5, 0,
                                         self.bottomLayoutGuide.length + 5, 0);
}

#pragma mark GMSMapViewDelegate

#pragma mark - infoWindow Methods

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
        //infoWindow setup
    UIView *iWindow = [UIView new];
    iWindow.frame = CGRectMake(0, 0, 200, 70);
    iWindow.backgroundColor = [UIColor cyanColor];
    
        //titleLabel setup
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(14, 11, 175, 16); //(x & y anchors in the superview, width & height)
    [iWindow addSubview:titleLabel];
    titleLabel.text = marker.title;
    
        //snippet setup
    UILabel *snippetLabel = [UILabel new];
    snippetLabel.frame = CGRectMake(14, 42, 175, 16);
    [iWindow addSubview:snippetLabel];
    snippetLabel.text = marker.snippet;
    
        //custom background image style
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GMSSprites-0-1x"]];
//    [iWindow addSubview:backgroundImage];
    
    marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);

//           return iWindow;
//==========================
//Alternative uiview:
// ==========================
    
    CustomInfoWindowView *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"CustomInfoWindow" owner:nil options:nil] objectAtIndex:0];
  infoWindow.placeName.text = @"Your location here!";
  infoWindow.address.text   = @"123 Sesame Street";
  infoWindow.photo.image    = [UIImage imageNamed:@"GMSSprites-0-1x"];
    
    return infoWindow;
}



#pragma mark - Events (delegate methods)

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    BOOL lovesMe = YES;
    BOOL lovesMeNot = !lovesMe;
    
    if (lovesMeNot) {
        NSString *message = [NSString stringWithFormat:@"You tapped selected (%.04f, %.04f). Confirm selection?", marker.position.latitude, marker.position.longitude];
        
        UIAlertController *windowTappedAlert = [UIAlertController alertControllerWithTitle:@"Confirm Tour-Stop Selection"
                                                                                   message:message
                                                                            preferredStyle:UIAlertControllerStyleActionSheet];
            //TODO:[Amitai]: Add action items (confirm selection; cancel; reverse/geocode it for me)
        
        
        [self presentViewController:windowTappedAlert animated:YES completion:nil];
    } else {
        //Make an alertcontroller to confirm selection.
        NSString *title = [NSString stringWithFormat:@"Add this location to your itinerary?"];
        NSString *message = [NSString stringWithFormat:@"Click \"Add Location\" to add this stop to your itinerary. Click \"Cancel\" to anonymously order a pizza to your ex\'s place...possibly."];
        UIAlertController *confirmSelection = [UIAlertController alertControllerWithTitle:title
                                                                                  message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Add Location" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.delegate userSelectedTourStopLocation:
             [[CLLocation alloc]initWithLatitude:marker.position.latitude longitude:marker.position.longitude]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel Me"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action) {
                                                                 NSLog(@"You cancelled me! ARGH!");
                                                             }];
        [confirmSelection addAction:defaultAction];
        [confirmSelection addAction:cancelAction];
        
        [self presentViewController:confirmSelection animated:YES completion:^{
            NSLog(@"Now what?");
        }];
    }
    
}




-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f, %f", coordinate.latitude, coordinate.longitude);
}

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
//    userSelection_ = [GMSMarker markerWithPosition:coordinate];
    
    userSelection_.map = nil;
    
    CLLocation *userSelection = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
        //!!![AMITAI]:Temporary short-circuit
    [self.delegate userSelectedTourStopLocation:userSelection];

    
    NSLog(@"You long-pressed at coordinate: (%f, %f)", coordinate.latitude, coordinate.longitude);
    
        // Create the marker and add it to the map
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    userSelection_ = marker;
        // Zoom into the current location
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:position zoom:15.0];
    [mapView_ animateToCameraPosition:cameraPosition];
    
}


-(UIAlertController*)confirmSelectionAlert:(CLLocation *)userSelectedLocation {
        //Make an alertcontroller to confirm selection.
    NSString *title = [NSString stringWithFormat:@"Add this location to your itinerary?"];
    NSString *message = [NSString stringWithFormat:@"Click \"Add Location\" to add this stop to your itinerary. Click \"Cancel\" to anonymously order a pizza to your ex\'s place...possibly."];
    UIAlertController *confirmSelection = [UIAlertController alertControllerWithTitle:title
                                                                              message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Add Location" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.delegate userSelectedTourStopLocation:userSelectedLocation];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel Me"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             NSLog(@"You cancelled me! ARGH!");
                                                         }];
    [confirmSelection addAction:defaultAction];
    [confirmSelection addAction:cancelAction];

    [self presentViewController:confirmSelection animated:YES completion:^{
        NSLog(@"Now what?");
    }];
    return confirmSelection;

}

/*
#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
}
*/
    
#pragma mark - leftover code (delete when this class works)
        //    [self setupMarkerData];
//}
/**
 *  Marker1 = FIS
 *  Marker2 = Statue of Liberty
 *  Marker3 = Amitai's Apartment growing up on the UWS (Deprecated 😦; it was a rental)
 */
-(void)setupMarkerData {
    GMSMarker *marker1 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.70531680012648,-74.01396463558194)];
        //    marker1.title = @"First marker!!";
        //    marker1.snippet = @"First Snippet!";
        //    marker1.appearAnimation = kGMSMarkerAnimationPop;
        //    marker1.draggable = YES;
    marker1.map = nil;
    
    
    GMSMarker *marker2 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.6892750, -74.0445560)];
    marker2.map = nil;
    
    GMSMarker *marker3 = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(40.7907300,-73.9723580)];
    marker3.map = nil;
    
    self.markers = [NSSet setWithObjects:marker1, marker2, marker3, nil];
    
    [self drawMarkers];
}



@end
