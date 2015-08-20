//
//  TRVTourCategoryView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTourCategory.h"


@interface TRVTourCategoryView : UIView

@property (nonatomic, strong) TRVTourCategory *categoryForThisView;


@property (strong, nonatomic) IBOutlet UIView *categoryContentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@end
