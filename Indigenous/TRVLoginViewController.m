//
//  TRVLoginViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVLoginViewController.h"
#import "TRVFacebookLoginHandler.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
#import "TRVButton.h"

@interface TRVLoginViewController ()

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;
@property (nonatomic, strong) TRVFacebookLoginHandler *loginHandler;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation TRVLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFacebookLoginButton];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([FBSDKAccessToken currentAccessToken] && [PFUser currentUser]) {
        
        NSLog(@"Facebook user logged in");
        PFObject *userBio = [PFUser currentUser][@"userBio"];
        [userBio fetchIfNeeded];
        NSNumber *isGuide = userBio[@"isGuide"];
        
        if ([isGuide isEqualToNumber:@(NO)]){
            [self transitionToHomeStoryboardWithFacebookID:[FBSDKAccessToken currentAccessToken].userID];
        } else {
            
            //TRANSITION TO GUIDE HOME PAGE
            
        }
        
        
    } else {
        NSLog(@"Facebook user not logged in.");
    }

        
}


-(void)setUpFacebookLoginButton{
    
    self.loginHandler = [[TRVFacebookLoginHandler alloc]initLoginWithButton:self.facebookLoginButton];
    
    [self.loginHandler loginToFacebook:^(BOOL success, NSString *facebookID) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"Email: %@ \nAbout to transition!", facebookID);
            [self transitionToHomeStoryboardWithFacebookID:facebookID];
        }];
    }];
    
}


- (IBAction)loginButtonPressed:(id)sender {

    
    
    [self transitionToHomeStoryboardWithEmail:self.emailTextField.text andPassword:self.passwordTextField.text];



}


-(void)transitionToHomeStoryboardWithFacebookID:(NSString *)facebookID {
    
    
    
    [self presentTouristHomeView];
    
    
}


-(void)transitionToHomeStoryboardWithEmail:(NSString*)email andPassword:(NSString*)password{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES]; // start progres hud
    hud.labelText = @"Logging In";
    
    [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error){
        
        [hud hide:YES];

        if (user){
            
            NSLog(@"User: %@", user);
            NSLog(@"bio: %@", user[@"userBio"]);
            PFObject *bioObject = user[@"userBio"];
            
            [bioObject fetchInBackgroundWithBlock:^(PFObject *object, NSError *error){
                
                if (object){
                    if ([user[@"userBio"][@"isGuide"] isEqualToNumber:@(YES)]){
                        // present guide home
                        // NEEDS TO GET DONE
                        
                        
                    } else {
                        // present guide home
                        [self presentTouristHomeView];
                        
                    }
                } else {
                    
                    NSLog(@"Unable to log in: %@", error);
                    UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Error Logging In" message:@"Please check your username and password.  Then try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertBox show];
                }
                
                
            }];
            
        } else {
            
            NSLog(@"Unable to log in: %@", error);
            UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Error Logging In" message:@"Please check your username and password.  Then try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertBox show];
            
        }
        
  
    }];
    
    
}


-(void)presentTouristHomeView {
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
   
   

}

-(void)viewDidDisappear:(BOOL)animated{
    
    UIStoryboard  *tourist = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];
    
    UIViewController  *destination = [tourist instantiateInitialViewController];
    
    [self.presentingViewController presentViewController:destination animated:NO completion:nil];
   
    [super viewDidDisappear:animated];
 
}


-(void)presentGuideHomeView {
    
    
    // NEED TO CREATE
    
}



- (IBAction)cancelButtonPressed:(id)sender {
    
    [self.loginHandler removeObserver];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}







- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
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
