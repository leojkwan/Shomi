//
//  TRVProfileViews.h
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TRVUser.h"

@interface TRVProfileViews : NSObject

@property (nonatomic, strong) UIView *profileView;


-(UIView *)createProfileViewWithUser:(TRVUser*)user;

@end
