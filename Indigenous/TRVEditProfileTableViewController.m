//
//  TRVEditProfileTableViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVEditProfileTableViewController.h"
#import "TRVUserDataStore.h"
#import <Masonry.h>

@interface TRVEditProfileTableViewController ()<UITextFieldDelegate>

//@property (nonatomic, strong) TRVEditTextViewController *editTextVC;

@property (weak, nonatomic) IBOutlet UIView *aboutMeContentView;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;
@property (weak, nonatomic) IBOutlet UITableViewCell *testCell;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *languagesTextField;



@property (weak, nonatomic) IBOutlet UITextView *taglineTextView;

@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;

@property (weak, nonatomic) IBOutlet UITextField *homeCityLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeCountryLabel;

@end

@implementation TRVEditProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    
    
    
    // set labels
    self.firstNameTextField.text = self.sharedDataStore.loggedInUser.userBio.firstName;
    self.lastNameTextField.text = self.sharedDataStore.loggedInUser.userBio.lastName;
    self.taglineTextView.text = self.sharedDataStore.loggedInUser.userBio.userTagline;
    NSLog(@"THIS IS THE LAST NAME %@", self.sharedDataStore.loggedInUser.userBio.userTagline);
    NSLog(@"THIS IS THE TAGLINE NAME %@", self.sharedDataStore.loggedInUser.userBio.userTagline);
    
    self.aboutMeTextView.text = self.sharedDataStore.loggedInUser.userBio.bioDescription;

    self.emailTextField.text = self.sharedDataStore.loggedInUser.userBio.email;
    self.languagesTextField.text = self.sharedDataStore.loggedInUser.userBio.language;
    self.homeCityLabel.text = self.sharedDataStore.loggedInUser.userBio.homeCity;
    self.homeCountryLabel.text = self.sharedDataStore.loggedInUser.userBio.homeCountry;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
//    NSLog(@"IN THE EDIT PROFILE VC WITH RETURNED TEXT: %@", self returnEditedText:(NSString *));

}



-(void)returnEditedText:(NSString*)text {
    
// returning text from edit storyboard
    NSString *textFromEditVC = text;
    NSLog(@"IN THE EDIT PROFILE VC WITH RETURNED TEXT: %@", textFromEditVC);
}

    
    
-(void)saveButtonPressed {
    NSLog(@"SAVED");
    
    PFUser *currentUser = [PFUser currentUser];
    
    PFObject *userBio = currentUser[@"userBio"];
//    self.sharedDataStore.loggedInUser
    
    
    
    // set on parse
    currentUser[@"email"] = self.emailTextField.text;
    userBio[@"first_name"] = self.firstNameTextField.text;
    userBio[@"last_name"] = self.lastNameTextField.text;
    userBio[@"email"] = self.emailTextField.text;
    userBio[@"languagesSpoken"] = self.languagesTextField.text;
    userBio[@"oneLineBio"] = self.taglineTextView.text;
    userBio[@"bioTextField"] = self.aboutMeTextView.text;
    userBio[@"homeCity"] = self.homeCityLabel.text;
    userBio[@"homeCountry"] = self.homeCountryLabel.text;

    
    //set locally
    self.sharedDataStore.loggedInUser.userBio.email = self.emailTextField.text;
    self.sharedDataStore.loggedInUser.userBio.language = self.languagesTextField.text;
    self.sharedDataStore.loggedInUser.userBio.firstName = self.firstNameTextField.text;
    self.sharedDataStore.loggedInUser.userBio.lastName = self.lastNameTextField.text;
    self.sharedDataStore.loggedInUser.userBio.userTagline = self.taglineTextView.text;
    self.sharedDataStore.loggedInUser.userBio.bioDescription = self.aboutMeTextView.text;
    self.sharedDataStore.loggedInUser.userBio.homeCity = self.homeCityLabel.text;
    self.sharedDataStore.loggedInUser.userBio.homeCountry = self.homeCountryLabel.text;


    
    // save on parse
    [currentUser saveInBackground];
    
    
    
    // save things to parse
    [self.navigationController popViewControllerAnimated:YES];
}
    
    
    
    
#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}




@end
