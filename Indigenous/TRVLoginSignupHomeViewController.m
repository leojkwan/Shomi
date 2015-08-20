//
//  TRVLoginSignupViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/29/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVLoginSignupHomeViewController.h"
#import "TRVFacebookLoginHandler.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
#import "TRVUserDataStore.h"
#import <Masonry.h>
#import <QuartzCore/QuartzCore.h>
#import "NSMutableArray+extraMethods.h"

@interface TRVLoginSignupHomeViewController () 

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation TRVLoginSignupHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
    [PFQuery clearAllCachedResults];
    [PFUser logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];

    
  
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)setUpUI{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"van2" ofType:@"gif"];
    NSData *gif = [NSData dataWithContentsOfFile:filePath];
    
    [self.webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    self.webView.userInteractionEnabled = NO;


    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"PFUSER: %@", [PFUser currentUser]);
    NSLog(@"FACEBOOK USER: %@", [FBSDKAccessToken currentAccessToken]);
    
    [self checkToSeeIfUserIsLoggedIn];

    
}

-(void)checkToSeeIfUserIsLoggedIn {
    

    
    if (self.isPerformingASwitch){
        self.isPerformingASwitch = NO;
        NSLog(@"Switching!");
        
        [self showLoadingView];

    } else if (([FBSDKAccessToken currentAccessToken] && [PFUser currentUser]) || [PFUser currentUser]) {
        
        [self showLoadingView];
        
        [self transitionToHome];
        
    } else {

        NSLog(@"No one logged in.");

    }


    
}

-(void)switchUserType {
    self.isPerformingASwitch = YES;
}


-(void)transitionToHome{
    [PFQuery clearAllCachedResults];

    TRVUserDataStore *user = [TRVUserDataStore sharedUserInfoDataStore];
    
    // User is logged in, do work such as go to next view controller.
    PFObject *userBio = [PFUser currentUser][@"userBio"];
    
    
    [userBio fetchInBackgroundWithBlock:^(PFObject *object, NSError *error){
        NSNumber *isGuide = userBio[@"isGuide"];
        if ([isGuide isEqualToNumber:@(NO)]){
            user.isOnGuideTabBar = NO;
            [self presentTouristHomeView];
        } else {
            user.isOnGuideTabBar = YES;
            [self presentGuideHomeView];
        }
        
    }];
    

}



-(void)presentTouristHomeView {
    
    
    UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];
    
    UIViewController *destination = [tourist instantiateInitialViewController];
    
    [self presentViewController:destination animated:YES completion:nil];
    
}

-(void)presentGuideHomeView {
    
    
    UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"RootGuideTabController" bundle:nil];
    
    UIViewController *destination = [tourist instantiateInitialViewController];
    
    [self presentViewController:destination animated:YES completion:nil];
    
}

-(void)showLoadingView {
    
//    self.loadingView = [[UIView alloc]init];
//    
//    self.loadingView.backgroundColor = [UIColor colorWithRed:244/255.0f green:242/255.0f blue:235/255.0f alpha:0];
//    
//    [self.view addSubview:self.loadingView];
//
//    
//    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(self.view);
//    }];
//    
//    
//    self.hud = [MBProgressHUD showHUDAddedTo:self.loadingView animated:YES];
//    
    self.registerButton.hidden = YES;
    self.signInButton.hidden = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.hud hide:YES];
    //[self.loadingView removeFromSuperview];
    self.registerButton.hidden = NO;
    self.signInButton.hidden = NO;
    [super viewDidDisappear:animated];
    
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
