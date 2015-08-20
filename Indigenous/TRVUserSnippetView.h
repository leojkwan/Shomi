//
//  TRVUserSnippetView.h
//  Indigenous
//
//  Created by Leo Kwan on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRVUser.h"
//#import "TRVBio.h"

@interface TRVUserSnippetView : UIView

@property (nonatomic, strong) TRVUser *userForThisSnippetView;


@property (strong, nonatomic) IBOutlet UIView *userSnippetContentView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneLinerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeCountryLabel;

@end
