//
//  TRVFacebookLoginHandler.h
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TRVFacebookLoginHandler : NSObject 


@property (nonatomic, copy) void (^loginCompletionBlock)(BOOL success, NSString *facebookID);

-(instancetype)initLoginWithButton:(FBSDKLoginButton*)button;
-(instancetype)initSignupWithButton:(FBSDKLoginButton*)button;


-(void)loginToFacebook:(void (^)(BOOL success, NSString *facebookID))completion;
-(void)userLoginStatusChanged;
-(void)removeObserver;

@end
