//
//  TRVProfileAboutMeView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserAboutMeView.h"
#import <Masonry.h>
#import "TRVUserDataStore.h"

@interface TRVUserAboutMeView()

@end

@implementation TRVUserAboutMeView



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
    
    // add yourself and make edges to 0
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        
        self.switchToGuideButton.layer.cornerRadius = 2.5;
    }];
    
    
}

-(void)checkIfuserForThisViewIsGuide {

    TRVUserDataStore *user = [TRVUserDataStore sharedUserInfoDataStore];

    if (self.userForThisAboutMeView.userBio.isGuide && user.isOnGuideTabBar) {
        [self.switchToGuideButton setTitle:@"Switch to Tourist" forState:UIControlStateNormal];
    } else if (self.userForThisAboutMeView.userBio.isGuide && (user.isOnGuideTabBar == NO)) {
        [self.switchToGuideButton setTitle:@"Switch to Guide" forState:UIControlStateNormal];
    } else {
        self.switchToGuideButton.hidden = YES;
    }
}

-(void)setUserForThisAboutMeView:(TRVUser *)userForThisAboutMeView {
    
    _userForThisAboutMeView = userForThisAboutMeView;
    self.userAboutMeLabel.text = userForThisAboutMeView.userBio.bioDescription;
    NSLog(@"%@", userForThisAboutMeView.userBio.bioDescription);
    [self checkIfuserForThisViewIsGuide];

}

@end
