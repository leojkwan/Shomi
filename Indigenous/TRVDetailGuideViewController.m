//
//  TRVDetailGuideViewController.m
//  Indigenous
//



#import "TRVDetailGuideViewController.h"

#import "TRVDetailGuideAllTripsDataSource.h"

#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import "NSMutableArray+extraMethods.h"
#import "TRVUser.h"
#import "TRVTourStop.h"
#import "TRVAllToursFilter.h"
#import "TRVTourDetailViewController.h"

// COCOAPODS
#import <Masonry.h>

// NIBS
#import "TRVUserSnippetView.h"
#import "TRVTourView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"

#import "TRVTouristTripDetailViewController.h"




@interface TRVDetailGuideViewController () <UITableViewDelegate>


@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (nonatomic, strong) UITableView *guideTripsTableView;
@property (nonatomic, strong) TRVDetailGuideAllTripsDataSource *tableViewDataSource;

//Number Of Tours In Segmented Tab
@property (nonatomic, strong) NSArray *guideCategoryTours;
@property (nonatomic, strong) NSArray *guideOtherTours;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) PFObject *PFTourForThisRow;
@end

@implementation TRVDetailGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];


    NSLog(@"%@", self.selectedGuideUser);
    
    //Instantiate a Image View Nib
    
    TRVUserProfileImageView *profileImageView = [[TRVUserProfileImageView alloc] init];
    profileImageView.userForThisProfileImageView = self.selectedGuideUser;
    
    [self.profileView addSubview:profileImageView];
    [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.profileView);
        make.height.equalTo(self.profileView.mas_width);
    }];
    
    
    //Instantiate a Snippet View Nib
    
    TRVUserSnippetView *snippetView = [[TRVUserSnippetView alloc] init];
    snippetView.userForThisSnippetView = self.selectedGuideUser;
    
    
    [self.profileView addSubview:snippetView];
    [snippetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImageView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
//        make.height.equalTo(@500);
    }];
    
    
    //Instantiate an ABOUT ME  Nib
    TRVUserAboutMeView *aboutMeView = [[TRVUserAboutMeView alloc] init];
    aboutMeView.userForThisAboutMeView = self.selectedGuideUser;

    // hide send me to tourguidetab button
        [aboutMeView.switchToGuideButton setHidden:YES];
    //make button shrink
        [aboutMeView.switchToGuideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0);
    }];

    
    [self.profileView addSubview:aboutMeView];
    [aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snippetView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
        
    }];
    
    //Instantiate a Contact View Nib
    
    TRVUserContactView *contactView = [[TRVUserContactView alloc] init];
    contactView.userForThisContactView = self.selectedGuideUser;
    
    [self.profileView addSubview:contactView];
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aboutMeView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    //    Instantiate a Segmented Control View
    
    
    // SET THE TAB BAR TO CATEGORY SEARCH
    TRVTourCategory *categoryForFirstTab = self.sharedDataStore.currentCategorySearching;
    NSString *categorySearchTabName = [NSString stringWithFormat:@"%@ Tours" ,categoryForFirstTab.categoryName];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:categorySearchTabName, @"Other Tours", nil]];
    self.segmentedControl.frame = CGRectMake(50, 200, 250, 50);
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents: UIControlEventValueChanged];
    
    
    [self.profileView addSubview:self.segmentedControl];

    // Segmented Control Constraints
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contactView.mas_bottom).with.offset(10);
        make.left.equalTo(self.profileView).with.offset(10);
        make.right.equalTo(self.profileView).with.offset(-10);
    }];

    
//    Instantiate a Table View

    self.guideTripsTableView = [[UITableView alloc] init];
    [self.profileView addSubview:self.guideTripsTableView];
 
    
    // Register cell
        [self.guideTripsTableView registerClass:[TRVTouristTripTableViewCell class] forCellReuseIdentifier:@"tripCell"];

        
    // set delegate and datasource owner
        self.tableViewDataSource = [[TRVDetailGuideAllTripsDataSource alloc] initWithGuide:self.selectedGuideUser];
        self.guideTripsTableView.dataSource = self.tableViewDataSource;
        self.guideTripsTableView.delegate = self;
    
    
    
//         FIND NUMBER OF CELLS TO DISPLAY AFTER DATASOURCE FILTER
        [TRVAllToursFilter getCategoryToursForGuide:self.selectedGuideUser withCompletionBlock:^(NSArray *response) {
            
                // SET CLASS PROPERTY WITH BLOCK RESPONSE FROM TABLE VIEW DATASOURCE
                self.guideCategoryTours = (NSMutableArray *) response[0];
                self.guideOtherTours = (NSMutableArray *) response[1];

            
            // Set Table View Constraints
            [self.guideTripsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.segmentedControl.mas_bottom).with.offset(10);
                make.left.and.right.equalTo(self.profileView);
                
            // hacky way to make table view longer
            NSNumber *cellHeight = @(320);
            NSNumber *tableViewHeight = @([cellHeight floatValue] * self.guideCategoryTours.count);
                
            make.height.equalTo(tableViewHeight);
            }];
        }];
        
    
    // Set Content View Constraints
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        //Add padding to bottom of VC
        make.bottom.equalTo(self.guideTripsTableView.mas_bottom).with.offset(10);
    }];
    }



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}


- (void)segmentedControlChanged:(UISegmentedControl *)segment
{
    
    [self.tableViewDataSource changeTripsDisplayed];
    
    // hacky way to make table view longer

    // Set Table View Constraints
    [self.guideTripsTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        // NUMBER OF TOURS X CELL HEIGHT (320) = TABLEVIEW HEIGHT
        NSNumber *tableViewHeight = nil;
        NSNumber *cellHeight = @(320);

        if (segment.selectedSegmentIndex == 0) {
            tableViewHeight = @([cellHeight floatValue] * self.guideCategoryTours.count);
        } else {
            tableViewHeight = @([cellHeight floatValue] * self.guideOtherTours.count);
        }
        make.height.equalTo(tableViewHeight);
    }];
    
    [self.profileView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.guideTripsTableView.mas_bottom).with.offset(10);
    }];

    self.guideTripsTableView.scrollEnabled = NO;
    [self.guideTripsTableView reloadData];
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"showTourDetailSegue" sender:self];
    
     NSIndexPath *ip = [self.guideTripsTableView indexPathForSelectedRow];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyTripsStoryboard" bundle:nil];
    TRVTouristTripDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"tourDetailVC"];
    TRVTour *tourForThisRow = [[TRVTour alloc] init];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        tourForThisRow = self.guideCategoryTours[ip.row];
        
        // CHECK IF THIS FIXES WHO THE REAL GUIDE IS IN OUR TOUR VIEW NIB
        tourForThisRow.guideForThisTour = self.selectedGuideUser;
        self.PFTourForThisRow = self.selectedGuideUser.PFCurrentCategoryTrips[ip.row];
    } else {
        tourForThisRow = self.guideOtherTours[ip.row];
        tourForThisRow.guideForThisTour = self.selectedGuideUser;
        self.PFTourForThisRow = self.selectedGuideUser.PFOtherCategoryTrips[ip.row];
    }

    
    viewController.tour = tourForThisRow;
    viewController.PFTour = self.PFTourForThisRow;
    NSLog(@"%@", viewController.tour.itineraryForThisTour.nameOfTour);
    [viewController isTourGuideTripViewController];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}




@end
