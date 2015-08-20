//
//  TRVProfileViewController.h
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"

@protocol SwitchUserProtocol <NSObject>
@required
-(void)switchUserType;
@end

@interface TRVProfileViewController : UIViewController

@property (nonatomic, strong) TRVUser *user;
@property (nonatomic, weak) id<SwitchUserProtocol> delegate;
@end
