//
//  CustomInfoWindowViewController.h
//  Indigenous
//
//  Created by Amitai Blickstein on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInfoWindowView : UIView

@property (nonatomic, weak) IBOutlet UILabel *placeName;
@property (nonatomic, weak) IBOutlet UILabel *address;
@property (nonatomic, weak) IBOutlet UIImageView *photo;
- (IBAction)closeButtonTapped:(id)sender;

@end
