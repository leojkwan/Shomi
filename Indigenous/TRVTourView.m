//
//  TRVTourView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourView.h"
#import "NSString+TRVExtraMethods.h"
#import <Masonry/Masonry.h>

@interface TRVTourView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *tourImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTourLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfStopsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *tourRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *upcomingDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *categoryIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tourPriceLabel;
@end

@implementation TRVTourView



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
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    [self.categoryIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.contentView.mas_height).dividedBy(8);
        make.width.equalTo(self.categoryIconImageView.mas_height);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.bottom.equalTo(self.contentView);
    }];
    
}

-(void)setTourForThisTourView:(TRVTour *)tourForThisTourView {
    
    _tourForThisTourView = tourForThisTourView;
    
    TRVItinerary *itineraryForThisView = tourForThisTourView.itineraryForThisTour;
    
    self.tourImageView.image = itineraryForThisView.tourImage;
    self.nameOfTourLabel.text = itineraryForThisView.nameOfTour;
    self.categoryIconImageView.image = tourForThisTourView.categoryForThisTour.iconImage;
    self.upcomingDateLabel.text = [NSString  formatDateDepartureForTour:tourForThisTourView];
    
    self.numberOfStopsLabel.text = [NSString stringWithFormat:@"%lu stops", itineraryForThisView.tourStops.count];;
    
    self.tourPriceLabel.text = [NSString stringWithFormat:@"$%@",tourForThisTourView.costOfTour];
    
    // Sets the decimal to 1 significant figure
//    self.tourRatingLabel.text = [NSString stringWithFormat:@"Average Rating - %.1f", tourForThisTourView.tourAverageRating];
};


@end
