//
//  NSMutableArray+TRVMutableArray_extraMethods.h
//  Indigenous
//
//  Created by Leo Kwan on 8/8/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUser.h"
#import <Foundation/Foundation.h>


@interface NSMutableArray (extraMethods)

@property (nonatomic, strong) TRVUser *guide;
+(NSMutableArray *) returnDummyAllTripsArrayForGuide:(TRVUser *)guide;
+(void)createParseDummyTour;
+(void)createParseDummyTour2;
+(void)createParseDummyTour3;



@end
