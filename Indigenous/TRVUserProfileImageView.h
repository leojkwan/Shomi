//
//  TRVUserProfileView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"

@interface TRVUserProfileImageView : UIView
@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (nonatomic, strong) TRVUser *userForThisProfileImageView;

@end
