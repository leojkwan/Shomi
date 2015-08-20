//
//  TRVTourStopCollectionViewCellView.m
//  Indigenous
//
//  Created by Daniel Wickes on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewCellView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation TRVTourStopCollectionViewCellView {
    UIColor *_defaultColor;
    UIColor *_selectedColor;
    UIColor *_usedColor;
}

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

-(void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    _defaultColor = [UIColor colorWithRed:253/255.0f green:97/255.0f blue:47/255.0f alpha:1];
    _usedColor = _defaultColor;
    _selectedColor = [UIColor colorWithRed:195/255.0f green:74/255.0f blue:53/255.0f alpha:1];
}

-(void)toggleColor:(void (^)())updateImageView  {
    if (_usedColor == _defaultColor) {
        _usedColor = _selectedColor;
        [UIView animateWithDuration:.25 animations:^{
            double rads = DEGREES_TO_RADIANS(90);
            CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
            self.transform = transform;
        } completion:^(BOOL finished) {
            updateImageView();
        }];
    }
    else {
        _usedColor = _defaultColor;
        [UIView animateWithDuration:.25 animations:^{
            //double rads = DEGREES_TO_RADIANS(-90);
            CGAffineTransform transform = CGAffineTransformIdentity; //CGAffineTransformRotate(CGAffineTransformIdentity, rads);
            self.transform = transform;
        }];
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, _usedColor.CGColor);
    CGContextSetStrokeColorWithColor(context, _usedColor.CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height/2 - .5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2 - .5);
    
    CGRect smallerRect = CGRectInset(rect, 5, 1);
    CGContextAddEllipseInRect(context, smallerRect);
    CGContextDrawPath(context, kCGPathFillStroke);
    
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGRect evenSmallerRect = CGRectInset(smallerRect, 10, 10);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillEllipseInRect(context, evenSmallerRect);
    
    }


@end
