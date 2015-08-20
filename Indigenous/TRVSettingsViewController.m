//
//  TRVSettingsViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 8/6/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSettingsViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TRVSettingsViewController ()

@end

@implementation TRVSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}





- (IBAction)logOutButtonPressed:(id)sender {
    
    [PFUser logOut];
    
    if ([FBSDKAccessToken currentAccessToken]){
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [FBSDKProfile setCurrentProfile:nil];
    }
  

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}



- (IBAction)dismissButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
