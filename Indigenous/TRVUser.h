//
//  TRVUser.h
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRVBio.h"
#import "TRVRating.h"

@interface TRVUser : NSObject

    //@property (nonatomic) BOOL isGuide;
@property (nonatomic, strong) NSString *parseObjectID; //Is this a string?
@property (nonatomic, strong) TRVBio *userBio;
@property (nonatomic) TRVRating *rating;
@property (nonatomic, strong) NSMutableArray *myTrips;
@property (nonatomic, strong) NSMutableArray *PFallTrips;
@property (nonatomic, strong) NSMutableArray *PFCurrentCategoryTrips;
@property (nonatomic, strong) NSMutableArray *PFOtherCategoryTrips;

//@property (nonatomic, strong) NSMutableArray *allTrips;  //past trips are tripHistory, futureTrips are, say, myUpcomingTrips.
@property (nonatomic, strong) NSMutableArray *tourCatalog;  //In the industry, a tour catalog is a publication by tour wholesalers listing their tour offerings. Catalogs are distributed to retail agents who make them available to their customers, and book them (for commissions). For our purposes, this is a listing of the Tours 'owned' by this user.
        //@property (nonatomic, strong) NSMutableArray *tripsLeading;
        //@property (nonatomic, strong) NSMutableArray *tripsTaking;


-(instancetype)initWithBio:(TRVBio *)bio;

@end
