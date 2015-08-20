//
//  TRVTourDescriptionNib.m
//  Indigenous
//
//  Created by Leo Kwan on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourDescriptionNib.h"
#import <Masonry.h>
@interface TRVTourDescriptionNib ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *tourDescriptionLabel; 


@end

@implementation TRVTourDescriptionNib




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

-(void)setTourForThisDescriptionNib:(TRVTour *)tourForThisDescriptionNib {
    
    _tourForThisDescriptionNib = tourForThisDescriptionNib;
    self.tourDescriptionLabel.text = tourForThisDescriptionNib.tourDescription;
    
};


@end
