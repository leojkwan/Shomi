//
//  TRVParagraphLabel.m
//  Indigenous
//
//  Created by Alan Scarpa on 8/14/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVParagraphLabel.h"

@implementation TRVParagraphLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.font = [UIFont fontWithName:@"AvenirNext" size:16.0];
    }
    return self;
}

@end
