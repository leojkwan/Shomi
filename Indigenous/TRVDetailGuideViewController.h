//
//  TRVDetailGuideViewController.h
//  Indigenous
//
//  Created by Leo Kwan on 8/5/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"

@interface TRVDetailGuideViewController : UIViewController

@property (nonatomic, strong) TRVUser *selectedGuideUser;
@property (weak, nonatomic) IBOutlet UIView *profileView;


@end
