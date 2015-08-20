//
//  TRVProfileViews.m
//  Indigenous
//
//  Created by Leo Kwan on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVProfileViews.h"
#import "TRVUserProfileImageView.h"
#import "TRVUserSnippetView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import <Masonry/Masonry.h>

@implementation TRVProfileViews

-(UIView *)createProfileViewWithUser:(TRVUser*)user {

    
    
    //Instantiate a Image View Nib
    
    TRVUserProfileImageView *profileImageView = [[TRVUserProfileImageView alloc] init];
    
    
    profileImageView.userForThisProfileImageView = user;
    [self.profileView addSubview:profileImageView];
    
    [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.profileView);
        make.height.equalTo(self.profileView.mas_width);
    }];
    
    
    //Instantiate a Snippet View Nib
    
    TRVUserSnippetView *snippetView = [[TRVUserSnippetView alloc] init];
    snippetView.userForThisSnippetView = user;
    [self.profileView addSubview:snippetView];
    
    [snippetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImageView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    //Instantiate an ABOUT ME  Nib
    
    TRVUserAboutMeView *aboutMeView = [[TRVUserAboutMeView alloc] init];
    aboutMeView.userForThisAboutMeView = user;
    [self.profileView addSubview:aboutMeView];
    [aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(snippetView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
        
    }];
    
    
    
    //Instantiate a Contact View Nib
    
    TRVUserContactView *contactView = [[TRVUserContactView alloc] init];
    contactView.userForThisContactView = user;
    [self.profileView addSubview:contactView];
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aboutMeView.mas_bottom);
        make.left.and.right.equalTo(self.profileView);
    }];
    
    // Set Container View Constraints
    
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.mas_width);
        make.bottom.equalTo(contactView.mas_bottom);
    }];
    
    
    
    return self.profileView;
}



@end
