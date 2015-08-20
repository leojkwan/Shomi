//
//  TRVNoNetworkModalView.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVNoNetworkModalView.h"
#import <Masonry/Masonry.h>

@interface TRVNoNetworkModalView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation TRVNoNetworkModalView


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
    
    [self addSubview:self.contentView];
      [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}


@end
