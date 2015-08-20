//
//  TRVFacebookLoginHandler.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVFacebookLoginHandler.h"
#import "TRVUserSignupHandler.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
@interface TRVFacebookLoginHandler () <FBSDKLoginButtonDelegate>


@property (strong, nonatomic) FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) FBSDKProfile *currentFacebookProfile;


@end

@implementation TRVFacebookLoginHandler


-(void)removeObserver{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
}

-(instancetype)initLoginWithButton:(FBSDKLoginButton*)button {
    
    self = [super init];
    if (self){
        _facebookLoginButton = button;
        
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginStatusChanged) name:FBSDKProfileDidChangeNotification object:nil];
    
    return self;
    
}


-(instancetype)initSignupWithButton:(FBSDKLoginButton*)button {
    
    self = [super init];
    if (self){
        _facebookLoginButton = button;
        
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSignupStatusChanged) name:FBSDKProfileDidChangeNotification object:nil];
    
    return self;
    
}

-(void)loginToFacebook:(void (^)(BOOL success, NSString *facebookID))completion{
    
    
    self.facebookLoginButton.delegate = self;
    self.facebookLoginButton.readPermissions =  @[@"email", @"public_profile", @"user_birthday"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    //login was successful
    self.loginCompletionBlock = completion;
    
    
}

-(void)userSignupStatusChanged{
    
    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    NSLog(@"Current Sign up Profile %@", self.currentFacebookProfile);
    
    if (self.currentFacebookProfile){
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.width(540).height(540), email, name, id, gender, birthday"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (error) {
                 NSLog(@"Login error: %@", [error localizedDescription]);
                 self.loginCompletionBlock(NO, nil);
                 return;
             }
             
             
              NSLog(@"fecthed user: %@  email: %@ birthday: %@, profilePhotoURL: %@", result, result[@"email"], result[@"birthday"], result[@"picture"][@"data"][@"url"]);
             
             [TRVUserSignupHandler addUserToParse:result withCompletion:^(BOOL success, NSError *error) {
                 if (success){
                     self.loginCompletionBlock(YES, result[@"id"]);
                     // TODO: do we need to nil out this block property? Is there a retain cycle between this handler & the VC?
                     //self.loginCompletionBlock = nil;
                     return;
                 }
                 self.loginCompletionBlock(NO, nil);
                 NSLog(@"Error adding user to parse: %@", error);
             }];
            
             
            
             
         }];
        
        
    }
    
    
}


-(void)userLoginStatusChanged{
    
    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    NSLog(@"Current Log in Profile %@", self.currentFacebookProfile);
    
    if (self.currentFacebookProfile){
        
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 
                 if (error) {
                     NSLog(@"Login error: %@", [error localizedDescription]);
                     self.loginCompletionBlock(NO, nil);
                     return;
                 }
                 
                
                 
                 // LOGIN
                 [PFUser logInWithUsernameInBackground:result[@"email"] password:result[@"id"] block:^(PFUser *user, NSError *error){
                     
                     if(user){
                         //SUCCESS - PRESENT NEXT VIEW
                         NSLog(@"Parse logged in");
                         self.loginCompletionBlock(YES, result[@"email"]);
                         // TODO: do we need to nil out this block property? Is there a retain cycle between this handler & the VC?
                         //self.loginCompletionBlock = nil;
                         
                     } else {
                        self.loginCompletionBlock(NO, nil);
                         
                     }
                     
                 }];
                 

             }];
      
        
    }
    
    
}





-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    
    //    self.currentFacebookProfile = [FBSDKProfile currentProfile];
    //    NSLog(@"%@", self.currentFacebookProfile);
    
    
}


- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
    
    
}

@end
