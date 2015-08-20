//
//  TRVUserSignupHandler.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVUserSignupHandler.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation TRVUserSignupHandler


+(void)addUserToParse:(NSDictionary*)userDetails withCompletion:(void (^)(BOOL success, NSError *error))completion {
    
  
    if ([PFUser currentUser]){
        [PFUser logOut];
    }
    PFUser *newUser = [PFUser new];
    newUser.username = userDetails[@"email"];
    newUser.password = userDetails[@"id"];
    newUser.email = userDetails[@"email"];
    newUser[@"facebookID"] = userDetails[@"id"];
    NSMutableDictionary *newDetails = [userDetails mutableCopy];
    PFObject *userBio = [PFObject objectWithClassName:@"UserBio"];
    NSString *profilePhotoURL = userDetails[@"picture"][@"data"][@"url"];
    [newDetails setValue:profilePhotoURL forKey:@"picture"];
    [userBio setValuesForKeysWithDictionary:newDetails];
    newUser[@"userBio"] = userBio;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        
        if (succeeded){
         
          completion(YES, nil);
            
        } else {
            [PFUser logOut];
            [FBSDKAccessToken setCurrentAccessToken:nil];
            [FBSDKProfile setCurrentProfile:nil];
            NSLog(@"Error signing up: %@", error);
            if (error.code == 200){
                NSLog(@"Missing username!");
                UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Invalid Username" message:@"Please enter a valid username" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertBox show];
            }
            else if (error.code == 202){
                NSLog(@"Username already taken!");
                UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Username already taken" message:@"Please try a different username" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertBox show];
            } else if (error.code == 203){
                NSLog(@"Email already taken!");
                UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Email already in use" message:@"Please enter a different email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertBox show];
            }
            completion(NO, error);
            
        }
        
    }];
}



@end
