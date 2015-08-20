//
//  TRVProfileViewController.m
//  Indigenous

#import <Masonry.h>

#import "TRVProfileViewController.h"
#import "TRVUserSnippetView.h"
#import "TRVUserAboutMeView.h"
#import "TRVUserContactView.h"
#import "TRVUserProfileImageView.h"
#import "TRVUserDataStore.h"
#import "TRVNetworkRechabilityMonitor.h"
#import <AFNetworkReachabilityManager.h>
#import "TRVLoginSignupHomeViewController.h"
#import "TRVUserDataStore.h"

@interface TRVProfileViewController () 
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) TRVUserDataStore *sharedDataStore;

@property (nonatomic, strong) TRVUserSnippetView *snippetView;
@property (nonatomic, strong) TRVUserContactView *contactView;
@property (nonatomic, strong) TRVUserAboutMeView *aboutMeView;


@end

@implementation TRVProfileViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sharedDataStore = [TRVUserDataStore sharedUserInfoDataStore];
    self.user = self.sharedDataStore.loggedInUser;
    
    
    
    // add tab bar
    UITabBarItem *profileTab = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profileTab"] selectedImage:[UIImage imageNamed:@"profileTab"]];
    self.tabBarItem = profileTab;
    
    
        TRVUserProfileImageView *profileImageView = [[TRVUserProfileImageView alloc] init];
        
    
        profileImageView.userForThisProfileImageView = self.sharedDataStore.loggedInUser;
        [self.containerView addSubview:profileImageView];
        
        [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self.containerView);
            make.height.equalTo(self.containerView.mas_width);
        }];
    
    
    //Instantiate a Snippet View Nib

        self.snippetView = [[TRVUserSnippetView alloc] init];
        self.snippetView.userForThisSnippetView = self.user;
        [self.containerView addSubview:self.snippetView];

        [self.snippetView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(profileImageView.mas_bottom);
            make.left.and.right.equalTo(self.containerView);

        }];
    
    //Instantiate an ABOUT ME  Nib
    
    self.aboutMeView = [[TRVUserAboutMeView alloc] init];
    self.aboutMeView.userForThisAboutMeView = self.user;
    [self.containerView addSubview:self.aboutMeView];
    [self.aboutMeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.snippetView.mas_bottom);
        make.left.and.right.equalTo(self.containerView);
    }];
    
    //add IBAction programatically
    UITapGestureRecognizer *singleTapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToGuideTab:)];
    [self.aboutMeView.switchToGuideButton addGestureRecognizer:singleTapOnImage];
    self.aboutMeView.switchToGuideButton.userInteractionEnabled = YES;

    
    
    
    //Instantiate a Contact View Nib

        self.contactView = [[TRVUserContactView alloc] init];
        self.contactView.userForThisContactView = self.user;
        [self.containerView addSubview:self.contactView];
        [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aboutMeView.mas_bottom);
            make.left.and.right.equalTo(self.containerView);
        }];
    
    // Set Container View Constraints
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.contactView.mas_bottom);
    }];

}

-(void)viewWillAppear:(BOOL)animated {

    // set the user every time this view appears
    self.snippetView.userForThisSnippetView = self.user;
    self.contactView.userForThisContactView = self.user;
    self.aboutMeView.userForThisAboutMeView = self.user;
    }


-(void)tapToGuideTab:(TRVUserContactView *)view {

    TRVUserDataStore *user = [TRVUserDataStore sharedUserInfoDataStore];

    if (user.isOnGuideTabBar) {
        user.isOnGuideTabBar = NO;
        [self goToTouristHome];
    } else {
        user.isOnGuideTabBar = YES;
        [self goToGuideHome];
    }

    
}

-(void)goToTouristHome {
    UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"TRVTabBar" bundle:nil];
    
    UIViewController *destination = [tourist instantiateInitialViewController];
    
    

    TRVLoginSignupHomeViewController *homeView = (TRVLoginSignupHomeViewController *)self.presentingViewController;
    
    // SET THE TRANSITION BACK TO PICK CITY BACK HOME
    destination.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    self.delegate = homeView;
    
    [self.delegate switchUserType];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        [homeView presentViewController:destination animated:NO completion:nil];
        
    }];
}


-(void)goToGuideHome {
    
    UIStoryboard *tourist = [UIStoryboard storyboardWithName:@"RootGuideTabController" bundle:nil];
    
    UIViewController *destination = [tourist instantiateInitialViewController];
    
    TRVLoginSignupHomeViewController *homeView = (TRVLoginSignupHomeViewController *)self.presentingViewController;
    
    destination.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    self.delegate = homeView;
    
    [self.delegate switchUserType];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        [homeView presentViewController:destination animated:NO completion:nil];
        
    }];
}

@end
