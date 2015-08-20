//
//  TRVRating_PF.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "PFObject.h"
#import <Foundation/Foundation.h>
#import <Parse.h>

@interface TRVRating_PF : PFObject <PFSubclassing>

@property (nonatomic, strong) NSNumber *touristRating;
@property (nonatomic, strong) NSNumber *guideRating;


@end
