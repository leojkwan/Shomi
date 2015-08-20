//
//  TRVBookTourTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/13/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVBookTourTableViewController.h"
#import "TRVTourReceiptViewController.h"
#import "NSString+TRVExtraMethods.h"
#import "TRVUserDataStore.h"
#import <Parse.h>


@interface TRVBookTourTableViewController ()

@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *tourGuideForThisLabel;


@property (weak, nonatomic) IBOutlet UILabel *guideFullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *guideProfileImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideTaglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfTourLabel;



@end

@implementation TRVBookTourTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    self.nameOfTourLabel.text = self.destinationTour.itineraryForThisTour.nameOfTour;
    
    
    NSString *guideFirstName = self.destinationTour.guideForThisTour.userBio.firstName;
    NSString *guideLastName = self.destinationTour.guideForThisTour.userBio.lastName;

    
    self.tourGuideForThisLabel.text = [NSString stringWithFormat:@"with %@", guideFirstName];
    
    self.guideFullNameLabel.text = [NSString stringWithFormat:@"%@ %@" , guideFirstName, guideLastName];
    
    NSString *dateOfTourForThisView = [NSString formatDateDepartureForTour:self.destinationTour];
    
    self.dateOfTourLabel.text = [NSString stringWithFormat:@"on %@" ,dateOfTourForThisView];
    
    self.guideTaglineLabel.text = self.destinationTour.guideForThisTour.userBio.userTagline;
    
    self.guideCityLabel.text = self.destinationTour.guideForThisTour.userBio.homeCity;
    
    self.guideCountryLabel.text = self.destinationTour.guideForThisTour.userBio.homeCountry;
    self.priceOfTourLabel.text = [NSString stringWithFormat:@"$%@", self.destinationTour.costOfTour];
    

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 4;
}

- (IBAction)goBackButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)bookTourButtonPressed:(id)sender {
    
    
    [self performSegueWithIdentifier:@"tourBookedSegue" sender:nil];

    PFUser *currentUser = [PFUser currentUser];
  
    self.destinationPFTour[@"isPurchased"] = @(YES);
    self.destinationPFTour[@"tourDeparture"] = self.destinationTour.tourDeparture;
    
    [currentUser addObject:self.destinationPFTour forKey:@"myTrips"];
    [currentUser save];
    
    if ([self.destinationTour.categoryForThisTour.categoryName isEqualToString:self.sharedDataStore.currentCategorySearching.categoryName]) {
        


    }

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TRVTourReceiptViewController *destinationVC = segue.destinationViewController;
    destinationVC.destinationTour = self.destinationTour;
    
}



@end
