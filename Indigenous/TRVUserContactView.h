//
//  TRVUserContactView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"


@interface TRVUserContactView : UIView

@property (nonatomic, strong) TRVUser *userForThisContactView;
@property (strong, nonatomic) IBOutlet UIView *userContactContentView;
@property (weak, nonatomic) IBOutlet UILabel *userLanguagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;

@end
