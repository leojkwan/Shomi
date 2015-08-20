//
//  TRVButton.m
//  
//
//  Created by Alan Scarpa on 8/14/15.
//
//

#import "TRVButton.h"
#import <Masonry.h>

@implementation TRVButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:20.0];
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.superview).multipliedBy(0.3);
//    }];
}


@end
