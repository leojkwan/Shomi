//
//  TRVTouristMyTripsViewController.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVTouristMyTripsViewController.h"
#import "TRVTouristTripDataSource.h"
#import "TRVTouristTripTableViewCell.h"
#import "TRVTouristTripDetailViewController.h"
#import "TRVUserDataStore.h"
#import "TRVUser.h"
#import "TRVTour.h"
#import "TRVTourStop.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TRVAFNetwokingAPIClient.h"

@interface TRVTouristMyTripsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tripTableView;
@property (nonatomic, strong) TRVTouristTripDataSource *tableViewDataSource;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) MBProgressHUD *noTours;
@end

@implementation TRVTouristMyTripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl.frame = CGRectMake(50, 200, 250, 30);
    
    
}


-(void)setUpUserAndTrips {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Trips";
    hud.labelFont = [UIFont fontWithName:@"Avenir" size:17];
    
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    [self.sharedDataStore setCurrentUser:[PFUser currentUser] withBlock:^(BOOL success) {
        
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            PFQuery *query = [PFUser query];
            [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
            
            [query getObjectInBackgroundWithId:[currentUser objectId] block:^(PFObject *user, NSError *error) {
                if (!error) {
                    
                    NSArray *myTrips = @[];
                    if (self.sharedDataStore.isOnGuideTabBar){
                        myTrips = user[@"myGuideTrips"];
                    } else {
                        myTrips = user[@"myTrips"];
                    }
                    
                    NSLog(@"MY TRIPS ARRAY FROM PARSE: %@", myTrips);
                    
                    if (myTrips.count == 0){
                        //add subview
                        [hud hide:YES];
                        self.noTours = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                        self.noTours.mode = MBProgressHUDModeText;
                        self.noTours.labelText = @"No Tours Found.  Get Searching!";
                        self.noTours.labelFont = [UIFont fontWithName:@"Avenir" size:17];
                        return;
                    }
                    
                    self.sharedDataStore.loggedInUser.myTrips = [[NSMutableArray alloc]init];
                    
                    
                    [self completeUser:self.sharedDataStore.loggedInUser bio:self.sharedDataStore.loggedInUser.userBio parseUser:[PFUser currentUser] allTrips:myTrips withCompletionBlock:^(BOOL success) {
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                            self.tableViewDataSource = [[TRVTouristTripDataSource alloc] initWithTrips:self.sharedDataStore.loggedInUser.myTrips configuration:nil];
                            self.tripTableView.dataSource = self.tableViewDataSource;
                            if (self.segmentedControl.selectedSegmentIndex == 1) {
                                [self.tableViewDataSource changeTripsDisplayed];
                            }
                            
                            [self.tripTableView reloadData];
                            
                            
                            [hud hide:YES];
                            
                        }];
                        
                    }];
                    
                } else {
                    // show modal
                }
            }];
        }
        
        
        
        
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    TRVUserDataStore *user = [TRVUserDataStore sharedUserInfoDataStore];
    if (!user.isOnGuideTabBar){
        self.addTourButton.enabled = NO;
        self.addTourButton.tintColor = [UIColor clearColor];
    } else {
        self.addTourButton.width = 0;
    }
    [self setUpUserAndTrips];
}

- (IBAction)segmentedControlChanged:(id)sender {
    [self.tableViewDataSource changeTripsDisplayed];
    [self.tripTableView reloadData];
}


-(void)completeUser:(TRVUser*)guideForThisRow bio:(TRVBio*)bio parseUser:(PFUser*)user allTrips:(NSArray *)myTrips withCompletionBlock:(void (^)(BOOL success))completion {
    
    NSOperationQueue *operationQ = [[NSOperationQueue alloc]init];
    [operationQ addOperationWithBlock:^{
        
        for (PFObject *PFTour in myTrips){
            
            
            // DOES THIS LINE WORK??
            [PFTour fetch];
            
            if ([PFTour[@"isPurchased"]isEqualToNumber:@(YES)] ) {
                
                
                
                
                TRVTour *tour = [[TRVTour alloc]init];
                
                
                // get guide for this tour info
                
                PFUser *userForThisTour = PFTour[@"guideForThisTour"];
                [userForThisTour fetch];
                PFObject *userBioForThisUser = userForThisTour[@"userBio"];
                [userBioForThisUser fetch];
                
                
                TRVUser *tourGuide = [[TRVUser alloc] init];
                tourGuide.userBio.firstName = userBioForThisUser[@"first_name"];
                
                
                
                if (userBioForThisUser[@"picture"]){
                    [TRVAFNetwokingAPIClient getImagesWithURL:userBioForThisUser[@"picture"] withCompletionBlock:^(UIImage *response) {
                        tourGuide.userBio.profileImage = response;
                    }];
                    
                } else {
                    
                    PFFile *pictureFile = userBioForThisUser[@"emailPicture"];
                    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            tourGuide.userBio.profileImage = [UIImage imageWithData:data];
                            tourGuide.userBio.nonFacebookImage = [UIImage imageWithData:data];
                        } else {
                            // error block
                        }
                    }];
                }
                
                
                tour.guideForThisTour = tourGuide;
                tour.costOfTour = PFTour[@"price"];
                tour.tourDescription = PFTour[@"tourDescription"];
                tour.categoryForThisTour = [TRVTourCategory returnCategoryWithTitle:PFTour[@"categoryForThisTour"]];
                tour.tourDeparture = PFTour[@"tourDeparture"];
                
                PFObject *PFItinerary = PFTour[@"itineraryForThisTour"];
                [PFItinerary fetch];
                
                TRVItinerary *itinerary = [[TRVItinerary alloc] init];
                itinerary.nameOfTour = PFItinerary[@"nameOfTour"];
                itinerary.numberOfStops =  [PFItinerary[@"numberOfStops"] integerValue];
                PFFile *imageForThisTour = PFItinerary[@"tourImage"];
                NSData *imageData = [imageForThisTour getData];
                itinerary.tourImage = [UIImage imageWithData:imageData];
                
                NSArray *tourStops = PFItinerary[@"tourStops"];
                NSMutableArray *TRVAllStops = [[NSMutableArray alloc] init];
                for (PFObject *PFStop in tourStops){
                    [PFStop fetch];
                    TRVTourStop *stop = [[TRVTourStop alloc] init];
                    stop.lng = [PFStop[@"lng"] floatValue];
                    stop.lat = [PFStop[@"lat"] floatValue];
                    stop.nameOfPlace = PFStop[@"nameOfPlace"];
                    stop.addressOfEvent = PFStop[@"addressOfEvent"];
                    stop.descriptionOfEvent = PFStop[@"descriptionOfEvent"];
                    PFFile *imageForStop = PFStop[@"image"];
                    NSData *stopImageData = [imageForStop getData];
                    stop.image = [UIImage imageWithData:stopImageData];
                    [TRVAllStops addObject:stop];
                }
                
                itinerary.tourStops = TRVAllStops;
                tour.itineraryForThisTour = itinerary;
                [guideForThisRow.myTrips addObject:tour];
                
            } // end of if statement
            
            
        } // END OF TOUR FOR LOOP
        
        
        
        completion(YES);
        
    }];
    
    
}



-(void)viewDidDisappear:(BOOL)animated {
    
    [self.noTours hide:YES];
    [super viewDidDisappear:animated];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"tripDetailSegue"]) {
        TRVTouristTripTableViewCell *cell = sender;
        TRVTouristTripDetailViewController *vc = segue.destinationViewController;
        vc.tour = cell.tour;
    }
}


@end
