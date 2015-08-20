//
//  TRVCity.h
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TRVCity : NSObject

@property (nonatomic, strong) NSString *nameOfCity;
@property (nonatomic, strong) UIImage *cityImage;


-(instancetype)initWithName:(NSString *)name image:(UIImage *)image;

@end
