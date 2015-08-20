//
//  TRVLabel.m
//  Indigenous
//
//  Created by Alan Scarpa on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVHeaderLabel.h"

@implementation TRVHeaderLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    self.font = [UIFont fontWithName:@"Avenir Next" size:25.0];
//}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:25.0];
    }
    return self;
}

@end
