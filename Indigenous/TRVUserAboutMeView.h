//
//  TRVProfileAboutMeView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"

@interface TRVUserAboutMeView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *userAboutMeLabel;
@property (weak, nonatomic) IBOutlet UIButton *switchToGuideButton;
@property (nonatomic, strong) TRVUser *userForThisAboutMeView;


@end
