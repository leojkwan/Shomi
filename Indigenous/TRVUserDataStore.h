//
//  TRVUserDataStore.h
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRVUser.h"
#import "TRVBio.h"
#import <Parse.h>
#import "TRVTourCategory.h"
#import <AFNetworkReachabilityManager.h>

@interface TRVUserDataStore : NSObject

+(instancetype)sharedUserInfoDataStore;
- (void) setCurrentUser:(PFUser *)currentUser withBlock:(void (^)(BOOL success))completionBlock;

@property (nonatomic) NSString *currentInternetStatus;

@property (nonatomic, strong) TRVUser *loggedInUser;
@property (nonatomic, strong) PFUser *parseUser;
@property (nonatomic, strong) TRVBio *bioForLoggedInUser;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *bioTextField;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSMutableArray *languagesSpoken;
@property (nonatomic) BOOL isGuide;
@property (nonatomic) BOOL isOnGuideTabBar;


// SET WHEN EAT/DRINK/PLAY/SEE IS SELECTED
// NECESSARY FOR FILTER MODAL
@property (nonatomic, strong) TRVTourCategory *currentCategorySearching;
@property (nonatomic, strong) NSDictionary *filterChoices;

@end


