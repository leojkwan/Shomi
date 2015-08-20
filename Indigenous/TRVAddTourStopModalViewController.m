//
//  TRVAddTourStopModalViewController.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//
#import <SCNumberKeyBoard.h>
#import "TRVAddTourStopModalViewController.h"
#import <Parse.h>
#import "CLLocation+initWith2D.h"
#import <CoreLocation/CLLocation.h>
#import "TRVLocationManager.h"

#define DBLG NSLog(@"%@ reporting!", NSStringFromSelector(_cmd));


@interface TRVAddTourStopModalViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//@property (weak, nonatomic) IBOutlet UISwitch *lngPlusMinusToggle;
//@property (weak, nonatomic) IBOutlet UISwitch *latPlusMinusToggle;
@property (weak, nonatomic) IBOutlet UITextField *latTxF;
@property (weak, nonatomic) IBOutlet UITextField *lngTxF;
@property (weak, nonatomic) IBOutlet UITextField *placeNameTxF;
@property (weak, nonatomic) IBOutlet UITextField *streetAddressTxF;
@property (weak, nonatomic) IBOutlet UITextField *cityTxF;
@property (weak, nonatomic) IBOutlet UITextField *stateTxF;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeTxF;
@property (weak, nonatomic) IBOutlet UIButton *saveTourStopButton;
- (IBAction)saveTourStopButtonTapped:(id)sender;
- (IBAction)reverseGeoCodeButtonTapped:(id)sender;
- (IBAction)geoCodeButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reverseGeoCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *geoCodeButton;
- (IBAction)toggleCoordSign:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButton:(id)sender;

@property (nonatomic) BOOL userLocationUpdated;



@end

@implementation TRVAddTourStopModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userLocationUpdated = NO;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [SCNumberKeyBoard showWithTextField:self.latTxF block:^(UITextField *textField, NSString *number) {
                NSLog(@"textField!: %@\nnumber (NSString)!: %@", [textField description], number);
            }];
    [SCNumberKeyBoard showWithTextField:self.lngTxF block:^(UITextField *textField, NSString *number) {
                NSLog(@"textField!: %@\nnumber (NSString)!: %@", [textField description], number);
            }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.latTxF.text && self.lngTxF.text) {
        self.reverseGeoCodeButton.enabled = YES;
        self.saveTourStopButton.enabled = YES;
    }
    if  (self.placeNameTxF.text.length ||
        (self.streetAddressTxF.text.length &&
         self.cityTxF.text.length &&
         self.stateTxF.text.length) ||
         self.postalCodeTxF.text) {
        
        self.geoCodeButton.enabled = YES;
    }
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Map helper methods

- (IBAction)getCurrentLocationButtonTapped:(id)sender {
    DBLG
}

#pragma mark - TableViewDelegate & TableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mapLocations.count; //Is this array getting filled in the first place???
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourStopCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tourStopCell"];
    }
    cell.textLabel.text = self.mapLocations[indexPath.row][@"name"];
    
    return cell;
}

/**
 *  Make an MKPinAnnotationView at the coord locations. Then you can drag it around and/or save it.
 *
 *  @return MKPinAnnotationView
 */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveTourStopButtonTapped:(id)sender {
}

- (IBAction)reverseGeoCodeButtonTapped:(id)sender {
    CLGeocoder *geocoder              = [[TRVLocationManager sharedLocationManager] geocoder];

    CLLocationDegrees lat             = (CLLocationDegrees)[self.latTxF.text doubleValue];
    CLLocationDegrees lng             = (CLLocationDegrees)[self.lngTxF.text doubleValue];
    CLLocationCoordinate2D testCoords = CLLocationCoordinate2DMake(lat,lng);
    CLLocation *testLocation          = [[CLLocation alloc] initWithCoordinate:testCoords];
    
    [geocoder reverseGeocodeLocation:testLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count) {
            CLPlacemark *resultsPlacemark = placemarks.firstObject;
            self.cityTxF.text          = resultsPlacemark.locality;
            self.streetAddressTxF.text = [NSString stringWithFormat:@"%@ %@", resultsPlacemark.thoroughfare, resultsPlacemark.subThoroughfare];
            self.postalCodeTxF.text    = resultsPlacemark.postalCode;
        }
        if (error) {
            DBLG
        }
        self.saveTourStopButton.enabled = YES;
    }];
    
    self.reverseGeoCodeButton.enabled = NO;
}

-(void)centerMapOnUserLocation {
    self.mapView.showsUserLocation = YES;
    [self.mapView                    setCenterCoordinate:self.mapView.userLocation.location.coordinate];
    self.userLocationUpdated       = YES;
}

- (IBAction)geoCodeButtonTapped:(id)sender {
    
}
/**
 *  stringLat → numLat → abs_value(numLat) → That x -1 → stringValue(That) = tada!
 *
 *  @param sender The UISwitch toggle...
 */
- (IBAction)toggleCoordSign:(UISwitch*)sender {
    switch (sender.tag) {
        case 1: //Latitude's toggle in IB
            self.latTxF.text = [NSString stringWithFormat:@"%@%@", (sender.state)? @"" : @"-", [@(labs([self.latTxF.text integerValue])) stringValue]];
            break;
        case 2: //Longitude's toggle in IB
            self.lngTxF.text = [NSString stringWithFormat:@"%@%@", (sender.state)? @"" : @"-", [@(labs([self.lngTxF.text integerValue])) stringValue]];
            break;
        default:
            DBLG
            break;
    }
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
