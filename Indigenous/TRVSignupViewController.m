//
//  TRVSignupViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSignupViewController.h"
#import "TRVFacebookLoginHandler.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface TRVSignupViewController ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) TRVFacebookLoginHandler *loginHandler;


@end

@implementation TRVSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFacebookSignupButton];
}

- (IBAction)cancelButtonPressed:(id)sender {
    
    [self.loginHandler removeObserver];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setUpFacebookSignupButton{
    
    self.loginHandler = [[TRVFacebookLoginHandler alloc]initSignupWithButton:self.facebookLoginButton];
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"Signing Up";
//    [hud show:YES];
    
    [self.loginHandler loginToFacebook:^(BOOL success, NSString *facebookID) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (success){
                NSLog(@"Fb ID: %@ \nAbout to transition!", facebookID);
               // [hud hide:YES];
                [self transitionToCompleteProfileViewWithFacebookID:facebookID];

            } else {
                // [hud hide:YES];
                NSLog(@"Error signing up");
            }
        }];
    }];
    
}


-(void)transitionToCompleteProfileViewWithFacebookID:(NSString*)facebookID {
    

    [self performSegueWithIdentifier:@"completeProfileSegue" sender:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
