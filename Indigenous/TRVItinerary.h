//
//  TRVItinerary.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <PFObject.h>

@interface TRVItinerary : NSObject

@property (nonatomic, strong, nonnull) NSString *nameOfTour;
@property (nonatomic, strong, nonnull) UIImage* tourImage;
@property (nonatomic) NSInteger numberOfStops;
@property (nonatomic, strong, nonnull) NSMutableArray *tourStops;
//@property (nonatomic, strong, nonnull) NSDate *dateOfTour;

@property (nonatomic, strong, nonnull) NSArray *attractions; //Attractions: Item of specific interest to travelers, such as natural wonders, manmade facilities and structures, entertainment, and activities.


-(instancetype)initNameOfTour:(NSString * __nonnull)name tourImage:(UIImage * __nullable)tourImage tourStops:(NSMutableArray * __nonnull)tourStops;

-(instancetype)init;

@end
