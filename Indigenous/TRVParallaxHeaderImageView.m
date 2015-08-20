//
//  TRVParallaxHeaderImageView.m
//  Indigenous
//
//  Created by Daniel Wickes on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVParallaxHeaderImageView.h"
#import "Masonry/Masonry.h"
#import "TRVTour.h"

@interface TRVParallaxHeaderImageView ()

@property (nonatomic, strong) UILabel *tourNameLabel;

@end

@implementation TRVParallaxHeaderImageView

-(instancetype)initWithFrame:(CGRect)frame andTour:(TRVTour*)tour
{
    if (self = [super initWithFrame:frame]) {
        self.tour = tour;
        
        self.image = tour.itineraryForThisTour.tourImage;
        
        [self setContentMode:UIViewContentModeScaleAspectFill];
        
        self.tourNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)]; // these values don't matter
        self.tourNameLabel.text = self.tour.itineraryForThisTour.nameOfTour;
        self.tourNameLabel.textColor = [UIColor whiteColor];
        self.tourNameLabel.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)makeConstraints {
    [self.tourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.equalTo(@30);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
