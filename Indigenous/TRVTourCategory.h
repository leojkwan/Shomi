//
//  TRVCategory.h
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TRVTourCategory : NSObject

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) UIImage *categoryImage;
@property (nonatomic, strong) UIImage *iconImage;

-(instancetype)initWithName:(NSString *)name cateogoryImage:(UIImage *)cateogoryImage iconImage:(UIImage *)iconImage;
-(instancetype)initWithName:(NSString *)name;

+(TRVTourCategory *)returnCategoryWithTitle:(NSString *)title;
+(TRVTourCategory *)returnSeeCategory;
+(TRVTourCategory *)returnDiscoverCategory;
+(TRVTourCategory *)returnEatCategory;
+(TRVTourCategory *)returnDrinkCategory;




@end
