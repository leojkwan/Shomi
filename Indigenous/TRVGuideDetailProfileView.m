//
//  TRVGuideDetailProfileView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVGuideDetailProfileView.h"
#import <Masonry.h>
#import <QuartzCore/QuartzCore.h>

@interface TRVGuideDetailProfileView ()
@property (strong, nonatomic) IBOutlet UIView *guideDetailedProfileView;
@property (weak, nonatomic) IBOutlet UIImageView *guideProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *guideFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guideDescription;


@end

@implementation TRVGuideDetailProfileView


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
    
    [self addSubview:self.guideDetailedProfileView];
    
    
    // set constraints for imageView to superview
    
    [self.guideDetailedProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    [self createCircleImageViewMask];

    
}


-(void)setGuideForThisDetailXib:(TRVUser *)guideForThisDetailXib {

    _guideForThisDetailXib = guideForThisDetailXib;
    self.guideProfileImageView.image = guideForThisDetailXib.userBio.profileImage;
    NSString *firstName = guideForThisDetailXib.userBio.firstName;
//    NSString *lastName = guideForThisDetailXib.userBio.lastName;
    NSString *fullName = [NSString stringWithFormat:@"About %@", firstName];
    self.guideFullNameLabel.text = fullName;
    self.guideDescription.text = self.guideForThisDetailXib.userBio.bioDescription;
    
}

-(void)createCircleImageViewMask {
    
    CALayer *imageLayer = self.guideProfileImageView.layer;
    //convert uicolor to CGColor
    imageLayer.borderColor = [[UIColor grayColor] CGColor];
    [imageLayer setCornerRadius:self.guideProfileImageView.frame.size.width/2];
    [imageLayer setBorderWidth:2];
    // This carves the cirle
    [imageLayer setMasksToBounds:YES];
    
}


@end
