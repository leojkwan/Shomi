//
//  TRVMyToursView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVMyToursView.h"
#import <Masonry.h>
#import "NSString+TRVExtraMethods.h"
#import "UIImageView+ExtraMethods.h"
#import "TRVTourStop.h"

@interface TRVMyToursView ()

@property (weak, nonatomic) IBOutlet UIImageView *tourImageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *upcomingDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *meetAtFirstStopLabel;
@property (weak, nonatomic) IBOutlet UILabel *withUserLabel;
@property (weak, nonatomic) IBOutlet UIImageView *withUserImage;


@end

@implementation TRVMyToursView




-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];

    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
}

-(void)setTourForThisTourView:(TRVTour *)tourForThisTourView {
    
    _tourForThisTourView = tourForThisTourView;
    
    TRVItinerary *itineraryForThisView = tourForThisTourView.itineraryForThisTour;
    
    self.tourImageView.image = itineraryForThisView.tourImage;
    
    self.nameOfTourLabel.text = itineraryForThisView.nameOfTour;
    
    
    self.withUserLabel.text = tourForThisTourView.guideForThisTour.userBio.firstName;
    
    
    NSString *dayAndMonthOfTrip = [NSString formatDateDepartureForTour:tourForThisTourView];
    
    self.upcomingDateLabel.text = [NSString stringWithFormat:@"on %@", dayAndMonthOfTrip];
    
    self.categoryIconImageView.image = tourForThisTourView.categoryForThisTour.iconImage;
    TRVTourStop *firstTourStop = itineraryForThisView.tourStops[0];
    self.meetAtFirstStopLabel.text = [NSString stringWithFormat:@"Meet at %@", firstTourStop.addressOfEvent];
    
    
    self.withUserImage.image = tourForThisTourView.guideForThisTour.userBio.profileImage;
    [UIImageView createCircleImageViewMaskWithImageView:self.withUserImage];

};




@end
