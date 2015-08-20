//
//  TRVSearchTripsTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSearchTripsTableViewController.h"
#import "TRVUser.h"
#import "TRVBio.h"
#import "TRVSearchTripsViewController.h"
#import "TRVSearchResultsDataSource.h"
#import <Masonry/Masonry.h>
#import "TRVFilterViewController.h"



@interface TRVSearchTripsTableViewController () <FilterProtocol>

@property (nonatomic, strong) TRVSearchResultsDataSource *resultsDataSource;
@property (nonatomic, strong) NSDictionary *filterDictionary;

@end

@implementation TRVSearchTripsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set datasource file
    self.resultsDataSource = [[TRVSearchResultsDataSource alloc] init];
    self.tableView.dataSource = self.resultsDataSource;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    TRVFilterViewController *filterModal = [segue destinationViewController];
    
    if (self.filterDictionary){
        filterModal.filterDictionary = self.filterDictionary;
    }
    
    filterModal.delegate = self;
    
}

-(void)passFilterDictionary:(NSDictionary *)dictionary{
    
    self.filterDictionary = dictionary;
    //THEN UPDATE SORTING
    [self updateGuidesList];
    NSLog(@"The dictionary: %@", self.filterDictionary);
    
}


-(void)updateGuidesList {
    // LEO
    // THIS IS ALL YOU
    // KILL IT
    // OR MAYBE I CAN DO IT
    // BUT WE SHALL SEE
    
    if (self.filterDictionary == nil){
        NSLog(@"Filter is nil!");
        
        // SHOW ALL GUDES
        
    } else {
        
        // USE SELF.FILTERDICTIONARY TO FILTER THE GUIDES
        
    }
    
}
@end
