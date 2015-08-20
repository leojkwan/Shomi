//
//  TRVPickCityTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVPickCityTableViewController.h"
#import "TRVCity.h"
#import "TRVCityTableViewCell.h"
#import "TRVUserDataStore.h"
#import <Parse.h>
#import <Masonry.h>
#import "TRVNoNetworkModalView.h"
#import "TRVTourCategoryViewController.h"
#import "TRVNetworkRechabilityMonitor.h"

@interface TRVPickCityTableViewController ()

@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) NSMutableArray *cities;
//@property (weak, nonatomic) IBOutlet TRVNoNetworkModalView *modalView;
@property (nonatomic, strong) IBOutlet TRVNoNetworkModalView *modalView;
@property (nonatomic, strong) NSString *selectedCity;
@end

@implementation TRVPickCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];

    
    [self.sharedDataStore setCurrentUser:[PFUser currentUser] withBlock:^(BOOL success) {
        // done
    }];
    
    
    
    
    TRVCity *newYork = [[TRVCity alloc] initWithName:@"New York" image:[UIImage imageNamed:@"newyork"]];
    TRVCity *losAngeles = [[TRVCity alloc] initWithName:@"Los Angeles" image:[UIImage imageNamed:@"LA"]];
    TRVCity *paris = [[TRVCity alloc] initWithName:@"Paris" image:[UIImage imageNamed:@"london"]];
    TRVCity *london = [[TRVCity alloc] initWithName:@"London" image:[UIImage imageNamed:@"madrid"]];
    
    self.cities = [[NSMutableArray alloc] initWithObjects:newYork, losAngeles, paris, london, nil];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated  {
    [self.navigationController setNavigationBarHidden:YES];

    
    // for the no internet modal... if there is no internet.. lock the scroll and present a full screen uiview
    [self.modalView setHidden:YES];
    self.tableView.scrollEnabled = YES;

    NSString *datastoreNetworkStatus = self.sharedDataStore.currentInternetStatus;
      if ([datastoreNetworkStatus isEqualToString:@"Not Reachable"]) {
        NSLog(@"OFFLINE !! ");
          [self.modalView setHidden:NO];
        [self.modalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view);
            make.height.equalTo(self.view);
            make.center.equalTo(self.view);
            self.modalView.backgroundColor = [UIColor orangeColor];
            self.tableView.scrollEnabled = NO;
        }];
      }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRVCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityReuseCell" forIndexPath:indexPath];
    TRVCity *cityForThisRow = self.cities[indexPath.row];
    cell.cityImageView.image = cityForThisRow.cityImage;
    cell.cityNameLabel.text = cityForThisRow.nameOfCity;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TRVCityTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // pass cell details into next vc...
    
    TRVCity *cityForThisRow = self.cities[indexPath.row];
    self.selectedCity = cityForThisRow.nameOfCity;
    NSLog(@"%@", cityForThisRow.nameOfCity);
    
    [self performSegueWithIdentifier:@"showCategoriesSegue" sender:self];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TRVTourCategoryViewController *destinationVC = [segue destinationViewController];
    destinationVC.selectedCity = self.selectedCity;
//    destinationVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    destinationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    // Pass the selected object to the new view controller.
}


@end
