//
//  TRVSignupWithEmailViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVSignupWithEmailViewController.h"
#import <Parse/Parse.h>

@interface TRVSignupWithEmailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *languageTextField;
@property (weak, nonatomic) IBOutlet UITextView *bioTextField;
@property (weak, nonatomic) IBOutlet UIButton *uploadProfilePhotoButton;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *oneLineBioTextField;
@property (weak, nonatomic) IBOutlet UISwitch *isGuide;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImage *profilePhoto;
@property (nonatomic, strong) PFFile *pfPhoto;
@property (weak, nonatomic) IBOutlet UISegmentedControl *homeCitySegmentedControl;
@property (nonatomic, strong) NSString *selectedHomeCity;


@end

@implementation TRVSignupWithEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}





- (IBAction)uploadProfilePhotoButtonPressed:(id)sender {
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    self.imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;

    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];

    
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    self.profilePhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    // Convert to JPEG with 50% quality
    NSData* data = UIImageJPEGRepresentation(self.profilePhoto, 0.3f);
    
    self.pfPhoto = [PFFile fileWithName:@"ProfilePhoto" data:data];
    
    [self.uploadProfilePhotoButton setTitle:@"Nice Pic!" forState:UIControlStateDisabled];
    self.uploadProfilePhotoButton.enabled = NO;
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)segmentSelected:(id)sender {
    
    if (self.homeCitySegmentedControl.selectedSegmentIndex == 0){
        
        self.selectedHomeCity = @"New York";
    } else if (self.homeCitySegmentedControl.selectedSegmentIndex == 1){
        
        self.selectedHomeCity = @"Los Angeles";
    } else if (self.homeCitySegmentedControl.selectedSegmentIndex == 2){
        
        self.selectedHomeCity = @"Paris";
    } else if (self.homeCitySegmentedControl.selectedSegmentIndex == 3){
        
        self.selectedHomeCity = @"London";
    } else {
        
        self.selectedHomeCity = @"Unknown";
    }
    
    
}


- (IBAction)doneButtonPressed:(id)sender {
    
    [self signUpUser];
    
}


-(void)signUpUser {
    
    if ([PFUser currentUser]){
        [PFUser logOut];
    }
    
    PFUser *newUser = [PFUser new];
    newUser.username = self.emailTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;
    newUser[@"isGuide"] = @(self.isGuide.on);
    
    newUser[@"userBio"] = [PFObject objectWithClassName:@"UserBio"];
    newUser[@"userBio"][@"isGuide"] = @(self.isGuide.on);
    newUser[@"userBio"][@"first_name"] = self.firstNameTextField.text;
    newUser[@"userBio"][@"last_name"] = self.lastNameTextField.text;
    newUser[@"userBio"][@"email"] = self.emailTextField.text;
    newUser[@"userBio"][@"gender"] = self.genderTextField.text;
    newUser[@"userBio"][@"birthday"] = self.birthdayTextField.text;
    newUser[@"userBio"][@"name"] = [NSString stringWithFormat:@"%@ %@", self.firstNameTextField.text, self.lastNameTextField.text];
    newUser[@"userBio"][@"bioTextField"] = self.bioTextField.text;
    newUser[@"userBio"][@"languagesSpoken"] = self.languageTextField.text;
    newUser[@"userBio"][@"oneLineBio"] = self.oneLineBioTextField.text;
    newUser[@"userBio"][@"phoneNumber"] = self.phoneNumberTextField.text;
    newUser[@"userBio"][@"homeCity"] = self.selectedHomeCity;
    
    // NEED TO ADD PICTURE STUFF
    if (self.pfPhoto){
        newUser[@"userBio"][@"emailPicture"] = self.pfPhoto;
    }
    
    [newUser signUpInBackgroundWithBlock:^(BOOL success, NSError *error){
        
        if (success){
            
            newUser[@"userBio"][@"user"] = [PFUser currentUser];
            [newUser saveInBackgroundWithBlock:^(BOOL success, NSError *error){
                
                if (success){
                    [self goToNextStoryboard];
                } else {
                    NSLog(@"Error signing up....");
                }
                
            }];
            
        } else {
            NSLog(@"Error signing up: %@", error);
            UIAlertView *alertBox = [[UIAlertView alloc]initWithTitle:@"Error Saving" message:@"Unable to sign up.  Try again later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertBox show];
            
        }
    }];

    
    
}


-(void)goToNextStoryboard {
    
    if (self.isGuide.on){
        UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"RootGuideTabController" bundle:nil];
        
        UIViewController *destination = [tourist instantiateInitialViewController];
        
        UIViewController *presentingViewController = self.presentingViewController;
        
        [presentingViewController dismissViewControllerAnimated:NO completion:^{
            [presentingViewController presentViewController:destination animated:NO completion:nil];
        }];

        
    } else {
        // TRANSITION TO TOURIST HOME PAGE
        // trvtabbar
        UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];
        
        UIViewController *destination = [tourist instantiateInitialViewController];
        
        UIViewController *presentingViewController = self.presentingViewController;
        
        [presentingViewController dismissViewControllerAnimated:NO completion:^{
            [presentingViewController presentViewController:destination animated:NO completion:nil];
        }];
        
    }

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
