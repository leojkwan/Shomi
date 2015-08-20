//
//  TRVGuideResultsTableViewController

//  Indigenous
//
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "NSMutableArray+extraMethods.h"
#import "TRVGuideResultsTableViewController.h"
#import "TRVTour.h"
#import "TRVUser.h"
#import "TRVBio.h"
#import "TRVSearchTripsViewController.h"
#import "TRVGuideProfileTableViewCell.h"
#import <Masonry/Masonry.h>
#import "TRVDetailGuideViewController.h"
#import "TRVFilterViewController.h"
#import "TRVUserDataStore.h"
#import "TRVAFNetwokingAPIClient.h"
#import <Parse.h>
#import "TRVTourStop.h"
#import <MBProgressHUD.h>

@interface TRVGuideResultsTableViewController () <UIGestureRecognizerDelegate, FilterProtocol, ImageTapProtocol>


@property (nonatomic, strong) NSDictionary *filterDictionary;
@property (nonatomic, strong) TRVUserDataStore *sharedData;
@property (nonatomic, strong) NSMutableArray *availableGuides;
@property (nonatomic, strong) TRVUser *destinationGuideUser;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic) NSUInteger userCount;
@property (nonatomic, strong) NSMutableArray *PFGuides;

@end

@implementation TRVGuideResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateGuidesList];
    
    self.sharedData = [TRVUserDataStore sharedUserInfoDataStore];
    self.PFGuides = [@[] mutableCopy];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@" NUMBER OF USERS!! %lu" , (unsigned long)self.availableGuides.count);
    return self.availableGuides.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.availableGuides.count > 0){
        
        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        
        cell.guideForThisCell = self.availableGuides[indexPath.row];
        
        // setting nib user will parse text labels for these nibs
        cell.profileImageViewNib.userForThisGuideProfileView = self.availableGuides[indexPath.row];
        cell.detailedProfileNib.guideForThisDetailXib = self.availableGuides[indexPath.row];
        
        // I CONFORM TO THE PROFILE IMAGE TAPPED PROTOCOL
        cell.profileImageViewNib.delegate = self;
        
        // add ibaction programaticcaly
        
        return cell;
    }
    else {
        
        // show a modal or something....
        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
        return cell;
    }
}


- (void)returnUserForThisImageNib:(TRVUser *)guideUser {
    self.destinationGuideUser = guideUser;
    [self performSegueWithIdentifier:@"detailGuideSegue" sender:nil];
}




-(void)passFilterDictionary:(NSDictionary *)dictionary{
    
    self.filterDictionary = dictionary;
    
    
}

-(void)updateGuidesList {
    
    self.availableGuides = [[NSMutableArray alloc]init];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"Loading Guides";
    
    PFQuery *query = [PFUser query];
    [query includeKey:@"userBio"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        
        NSOperationQueue *operationQ = [[NSOperationQueue alloc]init];
        [operationQ addOperationWithBlock:^{
            self.userCount = 0;
            [self findAppropriateGuides:objects];
            [self createGuides];
        }];
        
    }];
    
    if (self.filterDictionary == nil){
        // SHOW ALL GUDES
    } else {
        // USE SELF.FILTERDICTIONARY TO FILTER THE GUIDES
    }
    
    
    
}

-(void)findAppropriateGuides:(NSArray*)objects {
    for (PFUser *user in objects){
        PFObject *guideBio = user[@"userBio"];
        if ([guideBio[@"isGuide"] isEqualToNumber:@(YES)] && [guideBio[@"homeCity"] isEqualToString:self.selectedCity]){
            [self.PFGuides addObject:user];
        }
    }
}

-(void)createGuides {
    
    for (PFUser *user in self.PFGuides) {
        PFObject *guideBio = user[@"userBio"];
        TRVUser *guideForThisRow = [[TRVUser alloc]init];
        guideForThisRow.myTrips = [[NSMutableArray alloc]init];
        
        TRVBio *bio = [[TRVBio alloc]initGuideWithUserName:guideBio[@"name"]
                                                 firstName:guideBio[@"first_name"]
                                                  lastName:guideBio[@"last_name"]
                                                     email:guideBio[@"email"]
                                               phoneNumber:guideBio[@"phoneNumber"]
                                              profileImage:nil
                                            bioDescription:guideBio[@"bioTextField"]
                                                 interests:nil language:guideBio[@"languagesSpoken"]
                                                       age:0 gender:guideBio[@"gender"]
                                                    region:nil
                                            oneLineSummary:guideBio[@"oneLineBio"]
                                           profileImageURL:guideBio[@"picture"]
                                          nonFacebookImage:guideBio[@"emailPicture"]];
        
        // set more properties
        bio.homeCountry = guideBio[@"homeCity"];
        bio.homeCity = guideBio[@"homeCountry"];
        
        if (guideBio[@"picture"]){
            [TRVAFNetwokingAPIClient getImagesWithURL:guideBio[@"picture"] withCompletionBlock:^(UIImage *response) {
                bio.profileImage = response;
                guideForThisRow.userBio = bio;
                NSOperationQueue *operationQ = [[NSOperationQueue alloc]init];
                [operationQ addOperationWithBlock:^{
                    [self completeUser:guideForThisRow bio:bio parseUser:user];
                }];
            }];
            
        } else {
            
            PFFile *pictureFile = guideBio[@"emailPicture"];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    bio.profileImage = [UIImage imageWithData:data];
                    bio.nonFacebookImage = [UIImage imageWithData:data];
                    guideForThisRow.userBio = bio;
                    NSOperationQueue *operationQ = [[NSOperationQueue alloc]init];
                    [operationQ addOperationWithBlock:^{
                        [self completeUser:guideForThisRow bio:bio parseUser:user];
                    }];
                    
                } else {
                    // error block
                }
            }];
        }
    } // END OF FOR LOOP
    
}

-(void)completeUser:(TRVUser*)guideForThisRow bio:(TRVBio*)bio parseUser:(PFUser*)user {
    
    
    NSArray *allTours = user[@"myGuideTrips"];
    
    for (PFObject *PFTour in allTours){
        [PFTour fetch];
        TRVTour *tour = [[TRVTour alloc]init];
        tour.guideForThisTour = guideForThisRow;
        tour.tourDescription = PFTour[@"tourDescription"];
        NSNumber *priceOfTour = PFTour[@"price"];
        tour.costOfTour = priceOfTour;
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
        [guideForThisRow.PFallTrips addObject:PFTour];
        if ([PFTour[@"categoryForThisTour"] isEqualToString:self.sharedData.currentCategorySearching.categoryName]){
            [guideForThisRow.PFCurrentCategoryTrips addObject:PFTour];
        } else {
            [guideForThisRow.PFOtherCategoryTrips addObject:PFTour];
            
        }
        
    } // END OF TOUR FOR LOOP
    
    [self.availableGuides addObject:guideForThisRow];
    
    self.userCount++;
    if (self.userCount == self.PFGuides.count){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self.hud hide:YES];
        }];
        
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showFilter"]) {
        TRVFilterViewController *filterModal = [segue destinationViewController];
        if (self.filterDictionary){
            filterModal.filterDictionary = self.filterDictionary;
        }
        filterModal.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"detailGuideSegue"]) {
        
        
        TRVDetailGuideViewController *destinationVC = segue.destinationViewController;
        destinationVC.selectedGuideUser = self.destinationGuideUser;
        
    }
    
}


@end