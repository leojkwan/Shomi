//
//  TRVFilterViewController.h
//  Indigenous
//
//  Created by Alan Scarpa on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FilterProtocol <NSObject>
@required
-(void)passFilterDictionary:(NSDictionary*)dictionary;

@end


@interface TRVFilterViewController : UIViewController
@property (nonatomic, weak) id<FilterProtocol> delegate;
@property (nonatomic, strong) NSDictionary *filterDictionary;
@end
