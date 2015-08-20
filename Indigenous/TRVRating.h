//
//  TRVRating.h
//  Indigenous
//
//  Created by Leo Kwan on 7/28/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRVRating : NSObject

// there needs to be two ratings for each user
@property (nonatomic, strong) NSNumber *touristRating;
@property (nonatomic, strong) NSNumber *guideRating;

@end