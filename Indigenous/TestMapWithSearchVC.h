//
//  TestMapWithSearchVC.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>   //Needed for protocol
#import "TRVGoogleMapViewController.h" //contains protocol

@interface TestMapWithSearchVC : UISearchController

@property (nonatomic, strong) id<TRVPickerMapDelegate> delegate;

@end
