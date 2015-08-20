//
//  TRVTourCategoryView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVTourCategoryView.h"
#import <Masonry/Masonry.h>



@interface TRVTourCategoryView ()


@end

@implementation TRVTourCategoryView

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
    
    [self addSubview:self.categoryContentView];
    
    // This add subviews to show about root nib view
    [self.categoryContentView addSubview:self.categoryImageView];
    [self.categoryContentView addSubview:self.iconImageView];
//    [self.iconImageView setHidden:YES];
    [self.categoryContentView addSubview:self.categoryNameLabel];
    [self.categoryContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}


-(void)setCategoryForThisView:(TRVTourCategory *)categoryForThisView {
    

    _categoryForThisView = categoryForThisView;
    
    self.categoryImageView.image = categoryForThisView.categoryImage;
    self.iconImageView.image = categoryForThisView.iconImage;
    self.categoryNameLabel.text = categoryForThisView.categoryName;

    
}

@end
