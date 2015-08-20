////
////  TRVGuideResultsDataSource.m
////  Indigenous
////
////  Created by Leo Kwan on 8/8/15.
////  Copyright (c) 2015 Bad Boys 3. All rights reserved.
////
//
//#import "TRVGuideResultsDataSource.h"
//#import "TRVUser.h"
//#import "TRVBio.h"
//#import "TRVSearchTripsViewController.h"
//#import "TRVGuideResultsDataSource.h"
//#import "TRVGuideProfileTableViewCell.h"
//#import <Masonry/Masonry.h>
//#import "TRVDetailGuideViewController.h"
//#import "TRVFilterViewController.h"
//#import "TRVUserDataStore.h"
//
//
//@implementation TRVGuideResultsDataSource
//
//-(instancetype)initWithAvailableGuide:(NSMutableArray *)guides {
//    
//    self = [super init];
//    
//    if (self) {
//        _availableGuides = guides;
//    }
//    return self;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@" NUMBER OF USERS NO BLEEPING WAY!! %lu" , (unsigned long)self.availableGuides.count);
//    return self.availableGuides.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 350;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (self.availableGuides.count > 0){
//        
//        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
//        
//        cell.guideForThisCell = self.availableGuides[indexPath.row];
//        
//        
//        
//        
//        // setting nib user will parse text labels
//        cell.profileImageViewNib.userForThisGuideProfileView = self.availableGuides[indexPath.row];
//        
//        // add ibaction programaticcaly
//        
//        UITapGestureRecognizer *singleTapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//        [cell.profileImageViewNib addGestureRecognizer:singleTapOnImage];
//        cell.profileImageViewNib.userInteractionEnabled = YES;
//        
//        return cell;
//    }
//    else {
//        NSLog(@"THERE ARE NO AVAILABLE GUIDES IN THIS SEARCH RESULT");
//        TRVGuideProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tourGuideReuseCell"];
//        return cell;
//    }
//}
//
//
//
//
//@end
