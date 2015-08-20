//
//  TRVGuideProfileImageView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"

@protocol ImageTapProtocol

- (void)returnUserForThisImageNib:(TRVUser *)guideUser;

@end


@interface TRVGuideProfileImageView : UIView

@property (nonatomic, strong) TRVUser *userForThisGuideProfileView;
@property (nonatomic, assign) id <ImageTapProtocol> delegate;


@end
