//
//  TRVParallaxHeaderImageView.h
//  Indigenous
//
//  Created by Daniel Wickes on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRVTour;

@interface TRVParallaxHeaderImageView : UIImageView

@property (nonatomic, strong) TRVTour *tour;

-(instancetype)initWithFrame:(CGRect)frame andTour:(TRVTour*)tour;
-(void)makeConstraints;

@end
