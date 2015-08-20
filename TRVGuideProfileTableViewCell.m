//
//  TRVGuideProfileTableViewCell.m
//  Indigenous
//
//  Created by Leo Kwan on 8/2/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVGuideProfileTableViewCell.h"

#import <Masonry.h>

@interface TRVGuideProfileTableViewCell ()

@property (nonatomic, strong) NSArray *profileScrollViewItems;


@end

@implementation TRVGuideProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void) setGuideForThisCell:(TRVUser *)guideForThisCell {
    // override guide setter for cell
    _guideForThisCell = guideForThisCell;
    //override guide setter for nib WITHIN CELL BY SETTING THIS CELL GUIDE. 
    self.profileImageViewNib.userForThisGuideProfileView = guideForThisCell;
    
    [self layoutConstraintsForProfileSection];
}



-(void) layoutConstraintsForProfileSection {

    // Set Profile Image View Constraints
    
    if (![self.contentView.subviews containsObject:self.profileSectionContentView]) {
        [self.contentView addSubview:self.profileSectionContentView];
    }

    // Set constraints for ROOT PROFILE Content View
    [self.profileSectionContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        
//         SET the height of Profile scroll view to 2/3 of entire cell height
//        make.height.equalTo(self.contentView.mas_height).dividedBy(1.25);
        make.height.equalTo(self.contentView.mas_height);

        
        
    }];
    
    
    // LAYOUT NIBS
    [self layoutNibConstraints];
    
    // LAYOUT PROFILE SCROLL VIEW
    [self layoutProfileScrollView];
    
}



-(void) layoutProfileScrollView {
    
    // SET constraints for SCROLL VIEW
    [self.guideProfileScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        // Lock Scroll View Height
//        self.guideProfileScrollView.backgroundColor = [UIColor greenColor];
    }];
    
    
    
    
    //SET constraints for scroll CONTENT view
    
    [self.guideProfileScrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // Lock Scroll Content Height
//        make.height.equalTo(self.guideProfileScrollView.mas_height);
        
        // SET right margin of Scroll Content View To last item in items array
        
        make.right.equalTo(self.detailedProfileNib.mas_right);
    }];
}


-(void) layoutNibConstraints {
    

    if ([self.guideProfileScrollContentView.subviews count] == 0) { // Check that the nibs weren't added already
        // ADD Profile Image View Nib
        self.profileImageViewNib = [[TRVGuideProfileImageView alloc] init];
        
        [self.guideProfileScrollContentView addSubview:self.profileImageViewNib];
        
        // SET Profile Image View Nib Constraints
            [self.profileImageViewNib mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.guideProfileScrollView.mas_left);
            make.top.equalTo(self.guideProfileScrollView.mas_top);
            make.bottom.equalTo(self.guideProfileScrollView.mas_bottom);
            
            // Set aspect ratio of scroll view to be 1:1
            make.width.equalTo(self.guideProfileScrollView.mas_width);
        }];
        
        
        //SET DETAILED Profile View Nib Constraints
        self.detailedProfileNib = [[TRVGuideDetailProfileView alloc] init];
        [self.guideProfileScrollContentView addSubview:self.detailedProfileNib];
        
        
        // SET constraints for Profile View Nib
        [self.detailedProfileNib mas_makeConstraints:^(MASConstraintMaker *make) {
            // set all edges to superview edges except right margin
            make.left.equalTo(self.profileImageViewNib.mas_right);
            make.top.equalTo(self.guideProfileScrollContentView.mas_top);
            make.bottom.equalTo(self.guideProfileScrollContentView.mas_bottom);
            
            
            make.height.equalTo(self.guideProfileScrollView.mas_height);
            make.width.equalTo(self.guideProfileScrollView.mas_width);
        }];
    }
}


@end
