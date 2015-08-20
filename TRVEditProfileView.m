//
//  TRVEditProfileView.m
//  
//
//  Created by Leo Kwan on 8/9/15.
//
//

#import "TRVEditProfileView.h"

@implementation TRVEditProfileView


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

-(void)setUserForThisGuideProfileView:(TRVUser *)userForThisGuideProfileView {
    _userForThisGuideProfileView = userForThisGuideProfileView;
    
    self.profileImageView.image = userForThisGuideProfileView.userBio.profileImage;
    
    
    
    
    // SET TAGLINE LABEL AS BIO DESCRIPTION FOR NOW,
    self.guideTagLineLabel.text = userForThisGuideProfileView.userBio.bioDescription;
}


-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.guideProfileView];
    
    // add TAP RECOGNIZER for image tap
    UITapGestureRecognizer *profileImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.guideProfileView addGestureRecognizer:profileImageTap];
    self.guideProfileView.userInteractionEnabled = YES;
    
    
    
    // set constraints for imageView to superview
    [self.guideProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self createCircleImageViewMask];
}


@end
