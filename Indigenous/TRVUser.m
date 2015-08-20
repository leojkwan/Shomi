//
//  TRVUser.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUser.h"

@implementation TRVUser

-(instancetype)initWithBio:(TRVBio *)bio {
    
    self = [super init];
    
    if (self) {
        _userBio = bio;
        _PFallTrips = [[NSMutableArray alloc] init];
        _PFCurrentCategoryTrips = [[NSMutableArray alloc] init];
        _PFOtherCategoryTrips = [[NSMutableArray alloc] init];

    }
    return self;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _userBio = [[TRVBio alloc] init];
        _PFallTrips = [[NSMutableArray alloc] init];
        _PFCurrentCategoryTrips = [[NSMutableArray alloc] init];
        _PFOtherCategoryTrips = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
