//
//  TestMapWithSearchVC.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
// Made via HNKGooglePlacesAutocomplete's example project, and
// UseYourLoaf blog's suggest iOS 8 updates:
//http://useyourloaf.com/blog/2015/02/16/updating-to-the-ios-8-search-controller.html


#import "TestMapWithSearchVC.h"
#import <HNKGooglePlacesAutocomplete.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CLPlacemark+HNKAdditions.h>
#import <Masonry.h>

static NSString *const kHNKDemoMapAnnotiationIdentifier = @"kHNKDemoMapAnnotiationIdentifier";
static NSString *const kHNKDemoSearchResultsCellIdentifier = @"kHNKDemoMapAnnotiationIdentifier";

#pragma mark - Protocols
@interface TestMapWithSearchVC () <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) MKPointAnnotation *selectedPlaceAnnotation;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) HNKGooglePlacesAutocompleteQuery *searchQuery;
@property (nonatomic, assign) BOOL shouldBeginEditing;
    //Attach to an MKMapView on Storyboard
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
//    iOS 8 added LOC; This is a UISearchController(ViewController) with a TableView property,
//     but it could easily have been a UITableView with a Searchcontroller property.
@property (nonatomic, strong) UITableView *searchResultsTableView;
    //Attach to a UIView on Storyboard??

@end

@implementation TestMapWithSearchVC {
    NSUInteger errorCount_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        //for later, by fetch request...
    errorCount_ = 0;
    
    self.searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    self.shouldBeginEditing = YES;
    
//    self.mapView = [MKMapView new];
//    Masonry!!
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mapView.superview);
    }];
    self.mapView.delegate = self;
    
//        iOS 8 added LOC:
    self.searchResultsUpdater = self;
    self.dimsBackgroundDuringPresentation = NO;
    self.searchBar.scopeButtonTitles = @[NSLocalizedString(@"This is key1", @"comment1"),
                                         NSLocalizedString(@"This is key2", @"comment2")];
    self.searchBar.delegate = self;
//        Add the search bar view to the table view header:
    self.searchResultsTableView.tableHeaderView = self.searchBar;
    self.definesPresentationContext;
//???[AMITAI] Only if necessary...
    [self.searchBar sizeToFit];
    [self reloadInputViews];

}

#pragma mark - Protocol Conformance

#pragma mark MKMapView Delegate

/**
 *  I think this parallels GMSMarker's infoWindow, but is easier and more streamlined.
 *
 *  @param MKAnnotationView the 'infoWindow'
 *
 *  @return returns the popup
 */
    //If the map is wrong, return nil. If the annotation is the user's current location, returning 'nil' presents the 'pulsing blue dot', so this works for either possibility.
-(MKAnnotationView *)mapView:(MKMapView *)mapViewX viewForAnnotation:(id<MKAnnotation>)annotation {
    if (mapViewX != self.mapView || [annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
        //To return a standard pin annotation view, the method first attempts to dequeue an existing but no longer used annotation view. (If one isn't available, the method should create a new one...).
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:kHNKDemoMapAnnotiationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:kHNKDemoMapAnnotiationIdentifier];
    }
    
    annotationView.animatesDrop   = YES;
    annotationView.canShowCallout = YES;

    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [detailButton addTarget:self
                     action:@selector(annotationDetailButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    [self.mapView selectAnnotation:self.selectedPlaceAnnotation animated:YES];
}

-(void)annotationDetailButtonPressed:(id)sender
{
    NSLog(@"Pin tapped, yo!");
}


#pragma mark UISearchControllerDelegate
- (void)handleSearchForSearchString:(NSString *)searchString
{
    if ([searchString isEqualToString:@""]) {
        [self clearSearchResults]; //empty the search options if nothing is typed
    } else {
        [self.searchQuery fetchPlacesForSearchQuery:searchString
                                         completion:^(NSArray *places, NSError *error) {
                                             if (error) {
                                                 if (errorCount_ >= 10) {
                                                     return;
                                                 }
                                                 errorCount_ ++;
                                                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Error %lux: Could not fetch any Places", (unsigned long)errorCount_]
                                                                                                                message:error.localizedDescription
                                                                                                         preferredStyle:UIAlertControllerStyleAlert];
                                                 UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                                 [alert addAction:okButton];
                                                 [self presentViewController:alert animated:YES completion:nil];
                                             } else {
                                                 self.searchResults = places;
                                                 [self.searchResultsTableView reloadData];
                                             }
                                         }];
    }
    
}
//      Replaces - (BOOL)shouldReloadTableForSearchString:(NSString *)searchString [deprecated]
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    [self handleSearchForSearchString:searchString];
}

#pragma mark - UISearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchBar isFirstResponder]) {
        self.shouldBeginEditing = NO;
        [self setActive:NO];
        [self.mapView removeAnnotation:self.selectedPlaceAnnotation];
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (self.shouldBeginEditing) {
            //???[Amitai]: Animate in a table view...?
        NSTimeInterval animateDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animateDuration];
        self.searchResultsTableView.alpha = 0.75;
        [UIView commitAnimations];
        
        [self.searchBar setShowsCancelButton:YES animated:YES];
    }
    
    BOOL boolToReturn = self.shouldBeginEditing;
    self.shouldBeginEditing = YES;
    return boolToReturn;
}
//      Reloads the search results when the user changes the search scope:
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHNKDemoSearchResultsCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHNKDemoSearchResultsCellIdentifier];
    }
    
        //places array holds query results, see helper method(s)
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    
    return cell;
}


#pragma mark - Helpers
#pragma mark DataSource Helper

- (HNKGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return self.searchResults[indexPath.row];
}

#pragma mark Map Helpers

-(void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address {
    [self.mapView removeAnnotation:self.selectedPlaceAnnotation];
    
    self.selectedPlaceAnnotation = [MKPointAnnotation new];
    self.selectedPlaceAnnotation.coordinate = placemark.location.coordinate;
    self.selectedPlaceAnnotation.title = address;
    
    [self.mapView addAnnotation:self.selectedPlaceAnnotation];
}

- (void)recenterMapToPlacemark:(CLPlacemark *)placemark {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
    [self.mapView setRegion:region];
}

#pragma mark Search Helpers

- (void)clearSearchResults {
    self.searchResults = @[];
}

- (void)handleSearchError:(NSError *)error
{
    NSLog(@"ERROR = %@! WHY AM I YELLING??", error);
}


@end
