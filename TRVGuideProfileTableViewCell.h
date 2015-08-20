//
//  TRVGuideProfileTableViewCell.h
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"
#import "TRVBio.h"
#import "TRVGuideProfileTableViewCell.h"
#import "TRVGuideProfileImageView.h"
#import "TRVGuideDetailProfileView.h"

@interface TRVGuideProfileTableViewCell : UITableViewCell

@property (nonatomic, strong) TRVUser *guideForThisCell;

@property (weak, nonatomic) IBOutlet UIView *profileSectionContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *guideProfileScrollView;  
@property (weak, nonatomic) IBOutlet UIView *guideProfileScrollContentView;
@property (nonatomic, strong) TRVGuideProfileImageView *profileImageViewNib;
@property (nonatomic, strong) TRVGuideDetailProfileView *detailedProfileNib;

@end
