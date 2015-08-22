//
//  TRVItinerary.h
//  Indigenous
//
//  Created by Amitai Blickstein on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <PFObject.h>

@interface TRVItinerary : NSObject

@property (nonatomic, strong) NSString *nameOfTour;
@property (nonatomic, strong) UIImage* tourImage;
@property (nonatomic) NSInteger numberOfStops;
@property (nonatomic, strong) NSMutableArray *tourStops;
//@property (nonatomic, strong, nonnull) NSDate *dateOfTour;

@property (nonatomic, strong) NSArray *attractions; //Attractions: Item of specific interest to travelers, such as natural wonders, manmade facilities and structures, entertainment, and activities.


-(instancetype)initNameOfTour:(NSString *)name tourImage:(UIImage *)tourImage tourStops:(NSMutableArray *)tourStops;

-(instancetype)init;

@end
