//
//  TRVDetailGuideAllTripsDataSource.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVDetailGuideAllTripsDataSource.h"

#import "TRVDetailGuideViewController.h"

#import "TRVDetailGuideAllTripsDataSource.h"
#import "TRVTourDetailViewController.h"
#import "TRVUserDataStore.h"
#import "TRVTouristTripTableViewCell.h"
#import "NSMutableArray+extraMethods.h"
#import "TRVUser.h"
#import "TRVTour.h"
#import "TRVAllToursFilter.h"
#import "TRVTourStop.h"

// COCOAPODS
#import <Masonry.h>

// NIBS
#import "TRVUserSnippetView.h"
#import "TRVTourView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"



@interface TRVDetailGuideAllTripsDataSource()

@property (nonatomic, weak) NSArray *allTours;
@property (nonatomic, strong) TRVUser *selectedGuide;
@property (nonatomic, strong) NSMutableArray *toursOfSelectedCategory;
@property (nonatomic, strong) NSMutableArray *otherTours;
@property (nonatomic) BOOL categoryTab;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@end

@implementation TRVDetailGuideAllTripsDataSource

-(instancetype)initWithGuide:(TRVUser*)selectedGuide {
    self = [super init];
    
    if (self) {
        _selectedGuide = selectedGuide;
        _allTours = selectedGuide.myTrips;
        _sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
        _categoryTab = YES;
    }
    return self;
}


#pragma mark - Table View Delegate Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//     Return the number of rows in the section.
    [TRVAllToursFilter getCategoryToursForGuide:self.selectedGuide withCompletionBlock:^(NSArray *response) {
        
        // SET CLASS PROPERTY WITH BLOCK RESPONSE FROM TABLE VIEW DATASOURCE
        self.toursOfSelectedCategory = (NSMutableArray *) response[0];
        self.otherTours = (NSMutableArray *) response[1];
    }];
//        [self filterTripsByCategory];


    if (_categoryTab) {
        NSLog(@"NUMBER OF TOURS IN CATEGORY ARRAY!  %lu",(unsigned long)self.toursOfSelectedCategory.count);
        return self.toursOfSelectedCategory.count;
    }
    NSLog(@"NUMBER OF TOURS IN THIS OTHER TOURS ARRAY! %lu",(unsigned long)self.otherTours.count);
    return self.otherTours.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    

        TRVTour *tourForCell = nil;
    
    if(_categoryTab) {
        tourForCell = self.toursOfSelectedCategory[indexPath.row];
    }
    else {
        tourForCell = self.otherTours[indexPath.row];
    }
    
    
    // creating custom view of UITableView Cell
    TRVTourView *tourView = [[TRVTourView alloc] init];
    TRVTouristTripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tripCell" forIndexPath:indexPath];

    [cell addSubview:tourView];
    // set constraints for tour nib
    [tourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).with.offset(10);
        make.left.equalTo(cell).with.offset(5);
        make.right.equalTo(cell).with.offset(-5);
        make.bottom.equalTo(cell.mas_bottomMargin).with.offset(10);
    }];
    
    
        tourView.tourForThisTourView = tourForCell;

    tourView.backgroundColor = [UIColor redColor];
    
    //     self.guideTripsTableView.estimatedRowHeight = 300;
    
    cell.tour = tourForCell;
    return cell;
    
}

- (void) changeTripsDisplayed {
    _categoryTab = !_categoryTab;
}


@end

//showTourDetailSegue