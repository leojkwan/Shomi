//
//  TRVRating_PF.m
//  Indigenous
//
//  Created by Amitai Blickstein on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVRating_PF.h"
#import <PFObject+Subclass.h>

@implementation TRVRating_PF
+(void)load {
    [self registerSubclass];
}

+(NSString * __nonnull)parseClassName {
    return @"TRVRating_PF";
}



@end
