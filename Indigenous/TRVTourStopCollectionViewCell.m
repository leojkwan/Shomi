//
//  TRVCollectionViewCell.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewCell.h"
#import "TRVTourStopCollectionViewCellView.h"

@implementation TRVTourStopCollectionViewCell

-(void)selectionAnimation:(void (^)())updateImageView {
    //self.backgroundColor = [UIColor whiteColor];
    [self.myContentView toggleColor:updateImageView];
//    [UIView animateWithDuration:.25 animations:^{
//        double rads = DEGREES_TO_RADIANS(90);
//        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
//        self.myContentView.transform = transform;
//    } completion:^(BOOL finished) {
//        updateImageView();
//    }];
    //NSLog(@"selected cell's view's frame: %@", NSStringFromCGRect(_myContentView.frame));
    //updateImageView();
}

-(void)deselectionAnimation {
//    [UIView animateWithDuration:.25 animations:^{
//        double rads = DEGREES_TO_RADIANS(-90);
//        CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
//        self.myContentView.transform = transform;
//    }];
    [self.myContentView toggleColor:nil];
    
    //self.backgroundColor = [UIColor clearColor];
}
-(void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView removeFromSuperview];
    _myContentView = [[TRVTourStopCollectionViewCellView alloc] initWithFrame:self.bounds];
    [self addSubview:_myContentView];
    [self setNeedsLayout];
    [self bringSubviewToFront:_myContentView];
    
    _numStop = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 15, 15)];
    _numStop.backgroundColor = [UIColor clearColor];
    _numStop.textColor = [UIColor whiteColor];
    _numStop.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numStop];
    [self bringSubviewToFront:_numStop];
    
    NSLog(@"x coordinate: %f", self.frame.origin.x);
    NSLog(@"width: %f", self.frame.size.width);

    _myContentView.translatesAutoresizingMaskIntoConstraints = YES;
}


@end