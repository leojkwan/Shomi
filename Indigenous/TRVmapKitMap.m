//
//  TRVmapKitMap.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/11/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

/**
 *  This map is intended to be presented to the user in order to add locations, based upon
 * interests, etc., to choose and add locations (Tour Stops) to the itinerary being constructed
 * on the previous VC's view.
 *
 *  @param A
 *  @param B
 *
 *  @return CLLocation via delegate
 */

#import "TRVmapKitMap.h"

#define AVG(A,B) (A+B)/2

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));

    //!!![Amitai] don't forget the awesome hnk_placemarkFromGooglePlace:apiKey:completion:

static NSString *const kTRVMapAnnotationIdentifier     = @"kTRVMapAnnotationIdentifier";
static NSString *const kTRVSearchResultsCellIdentifier = @"kTRVSearchResultsCellIdentifier";


@interface TRVmapKitMap ()

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *mapLocations;
@property (nonatomic) BOOL userLocationUpdated;

@property (nonatomic, strong) CLPlacemark *place;
@property (nonatomic, strong) CLLocation *location;


- (void)locationUpdated:(NSNotification *)notification;

@end

@implementation TRVmapKitMap

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self centerMapOnNYC];
//    self.mapView.showsUserLocation = YES;
    if (self.userLocationUpdated != TRUE) {
        [self centerMapOnUserLocation];
    }
    
    HNKGooglePlacesAutocompleteQuery *searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil]; //nil for now, but I could see a Searchresults controller being helpful.
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.navigationItem.titleView = self.searchController.searchBar;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    [self.view addSubview:self.mapView];
//    [self.view addSubview:self.searchBarPlaceholder];
    [self.searchController.searchBar sizeToFit];
    self.definesPresentationContext = YES;
    self.modalPresentationCapturesStatusBarAppearance = YES;

    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                      action:@selector(handleLongPressRecognizer:)];
    [self.mapView addGestureRecognizer:longPressRecognizer];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark Helpers

-(void)centerMapOnNYC {
    CLLocationCoordinate2D centerNYC  = CLLocationCoordinate2DMake(40.7053,-74.0139);

    CLLocationDistance regionWidth    = 1500;//in meters, mind you.
    CLLocationDistance regionHeight   = 1500;

    MKCoordinateRegion startNYCRegion = MKCoordinateRegionMakeWithDistance(centerNYC, regionWidth, regionHeight);
    [self.mapView setRegion:startNYCRegion animated:YES];
}

-(void)centerMapOnUserLocation {
    self.mapView.showsUserLocation = YES;
    [self.mapView                    setCenterCoordinate:self.mapView.userLocation.location.coordinate];
    self.userLocationUpdated       = YES;
}

    //Need to reset the region to a box that will contain all your annotations...
-(void)addAndCenterOnLocations:(NSArray *)locations {
        //annotations have already been added here
        //declare the far corners of the world...of annotations:
    CLLocationDegrees minLat = 0;
    CLLocationDegrees minLng = 0;
    CLLocationDegrees maxLat = 0;
    CLLocationDegrees maxLng = 0;
    
        //choose the extremes of lat and long...
    for (CLLocation *location in locations) {
        minLat = MIN(minLat, location.coordinate.latitude);
        minLng = MIN(minLng, location.coordinate.longitude);
        maxLat = MAX(maxLat, location.coordinate.latitude);
        maxLng = MAX(maxLng, location.coordinate.longitude);
    }
    
    CLLocation *centerPoint = [[CLLocation alloc] initWithLatitude:AVG(minLat, maxLat)
                                                  longitude:AVG(minLng, maxLng)];
        //...to obtain the center.
    CLLocationCoordinate2D annotationsCenter = centerPoint.coordinate;
    
        //Determine how big your map must be to display them all.
    MKCoordinateSpan annotationsSpan = MKCoordinateSpanMake(ABS(maxLat - minLat),
                                                          ABS(maxLng - minLng));
    
    MKCoordinateRegion region = MKCoordinateRegionMake(annotationsCenter, annotationsSpan);
    
        //With all that as preparation, set the map to the new region.
    [self.mapView setRegion:region];
}

    //TODO: Make sure that something uses this method.
/**
 *
 * CLPlacemark properties:
 name
 ISOcountryCode
 country
 postal code
 administrativeArea (state)
 subAdministrativeArea (county)
 locality (city)
 subLocality (neighborhood, 'common name')
 thoroughfare (street address)
 subThoroughfare (building number)
 region (CLRegion the placemark appears in)
 *
 *  @param location A location defined by lat and lng.
 *  @returns in the completion block, sets the VC's 'place' propertty
 */
                                       

#pragma mark SearchBar Delegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    DBLG
}

- (void)locationUpdated:(NSNotification *)notifcation {
        //??? Anybody home?
}

#pragma mark MapView Delegate methods

- (void)handleLongPressRecognizer:(UIGestureRecognizer*)sender {
    sender.enabled = NO;
        //Get the point in the view, turn it into a coordinate...
    CGPoint point = [sender locationInView:self.mapView];
    CLLocationCoordinate2D touchedCoordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        //...create your annotation.
    TRVTourStop *dropPin = [[TRVTourStop alloc] initWithCoordinates:touchedCoordinate];
    MKAnnotationView *dropPinView = [[MKAnnotationView alloc] initWithAnnotation:dropPin reuseIdentifier:kTRVMapAnnotationIdentifier];
    dropPinView.draggable = YES;
    [self.mapView addAnnotation:dropPin];
    DBLG
    [TRVLocationManager logLocationToConsole:dropPin.tourStopCLLocation];
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil; //because we want our pulsing blue dot!
    }
    MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kTRVMapAnnotationIdentifier];
    
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kTRVMapAnnotationIdentifier];
    }
    
    return view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    DBLG
}

@end
