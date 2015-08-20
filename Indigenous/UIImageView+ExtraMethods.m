//
//  UIImageView+ExtraMethods.m
//  Indigenous
//
//  Created by Leo Kwan on 8/17/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "UIImageView+ExtraMethods.h"

@implementation UIImageView (ExtraMethods)


+(void)createCircleImageViewMaskWithImageView:(UIImageView*)imageView {
    
    CALayer *imageLayer = imageView.layer;
    //convert uicolor to CGColor
    imageLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    [imageLayer setCornerRadius:imageView.frame.size.width/2];
    [imageLayer setBorderWidth:2];
    // This carves the cirle
    [imageLayer setMasksToBounds:YES];
    
}


@end
