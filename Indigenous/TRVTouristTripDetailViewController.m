//
//  TRVTouristTripDetailViewController.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTouristTripDetailViewController.h"
#import "TRVTour.h"
#import "TRVTourStopCollectionViewDataSource.h"
#import "TRVTourStopCollectionViewDelegateFlowLayout.h"
#import "UIScrollView+APParallaxHeader.h"
#import "TRVParallaxHeaderImageView.h"
#import "TRVTourDescriptionNib.h"
#import "TRVBookTourTableViewController.h"
#import "TRVTourStop.h"

#import "Masonry/Masonry.h"

@interface TRVTouristTripDetailViewController () <APParallaxViewDelegate, TourStopInfoDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *tourStopCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *tourStopImageView;
@property (nonatomic, strong) TRVTourStopCollectionViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollViewThatHoldsAllTheOtherViews;
@property (nonatomic, strong) TRVTourStopCollectionViewDelegateFlowLayout *collectionViewDelegate;
@property (nonatomic, strong) TRVParallaxHeaderImageView *parallaxImageView;
@property (nonatomic, strong) UILabel *parallaxHeaderTourNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBookTourButtonConstraint;
@property (weak, nonatomic) IBOutlet UIButton *bookTourButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tourStopImageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bookTourBottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *nameOfStop;

@property (weak, nonatomic) IBOutlet TRVTourDescriptionNib *tourDescriptionNib;


@property (nonatomic) BOOL isTourGuide;
@end

@implementation TRVTouristTripDetailViewController {
    CGFloat _originalDistanceFromBottomOfScreenToBottomOfParallaxImage;
    CGFloat _savedAlphaValue;
    BOOL    _initialSetup;
    BOOL    _startIt;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _isTourGuide = NO;
        _initialSetup = NO;
        _startIt = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTitle.title = self.tour.itineraryForThisTour.nameOfTour;
    
    
    
    
//   // set tour for tour description nib
    self.tourDescriptionNib.tourForThisDescriptionNib = self.tour;
    [self.tourDescriptionNib performSelector:@selector(setTourForThisDescriptionNib:) withObject:self.tour afterDelay:.25];
    NSLog(@"%@", self.tour.tourDescription);
    
    
    self.dataSource = [[TRVTourStopCollectionViewDataSource alloc] initWithStops:self.tour.itineraryForThisTour.tourStops configuration:^(TRVTourStop * stop) {
       
    }];
    self.tourStopCollectionView.dataSource = self.dataSource;
    self.collectionViewDelegate = [[TRVTourStopCollectionViewDelegateFlowLayout alloc] init]; // UILayoutContainerView
    self.collectionViewDelegate.delegate = self;
    self.tourStopCollectionView.allowsMultipleSelection = NO;
    
    self.tourStopCollectionView.delegate = self.collectionViewDelegate;
    self.tourStopCollectionView.scrollsToTop = NO;
    
    //[self.tourStopCollectionView reloadData];
    
    NSIndexPath *indexPath = [self.tourStopCollectionView indexPathForItemAtPoint:CGPointMake(10, 10)];
    [self.tourStopCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.tourStopCollectionView.delegate collectionView:self.tourStopCollectionView didSelectItemAtIndexPath:indexPath];
    
    //[self.tourStopImageView.autoresizingMask = UIImag]
    
    [self setupParallaxImage:self.theScrollViewThatHoldsAllTheOtherViews];
    

    
    _savedAlphaValue = 1;


    if (_isTourGuide == YES){
        [self setUpTourGuideViewController];
    }
    [self selectFirstItemInCollectionView];
    [self performSelector:@selector(selectFirstItemInCollectionView) withObject:self afterDelay:.25];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)isTourGuideTripViewController {
    _isTourGuide = YES;
}

-(void)setUpTourGuideViewController {
    self.bookTourButton.hidden = NO;
    self.bookTourButton.backgroundColor = [UIColor colorWithRed:253/255.0f green:97/255.0f blue:47/255.0f alpha:1];

    [NSLayoutConstraint activateConstraints:self.bookTourButton.constraints];
    self.tourStopImageViewBottomConstraint.active = NO;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ((*targetContentOffset).y == -224) {
        [self makeContentInsetFullScreen:scrollView];
    }
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.parallaxImageView.bounds.size.height - self.view.bounds.size.height / 10, self.view.bounds.size.width, self.view.bounds.size.height / 10)];
}

- (void)makeContentInsetFullScreen:(UIScrollView *)scrollView {
    UIScreen *screen = [UIScreen mainScreen];
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top = screen.bounds.size.height;
    scrollView.contentInset = inset;
    scrollView.contentOffset = CGPointMake(0, -scrollView.contentInset.top);
    _startIt = YES;
}

- (void)setupParallaxImage:(UIScrollView *)scrollView {
    CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
    self.parallaxImageView = [[TRVParallaxHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, width, width/2) andTour:self.tour];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedParrallaxImage)];
    [self.parallaxImageView addGestureRecognizer:tap];
    self.parallaxImageView.userInteractionEnabled = YES;
    
    [self.theScrollViewThatHoldsAllTheOtherViews addParallaxWithView:self.parallaxImageView andHeight:self.parallaxImageView.bounds.size.height];
    [self setupParallaxImageTitle];
    //[self.theScrollViewThatHoldsAllTheOtherViews bringSubviewToFront:self.parallaxHeaderTourNameLabel];
    [self makeContentInsetFullScreen:self.theScrollViewThatHoldsAllTheOtherViews];
    
    //
    [self.tourDescriptionNib.superview layoutSubviews];
}

- (void)setupParallaxImageTitle {
    self.parallaxHeaderTourNameLabel = [[UILabel alloc] init];
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor magentaColor];
    self.parallaxHeaderTourNameLabel.text = self.tour.itineraryForThisTour.nameOfTour;
    
    
    [self.parallaxHeaderTourNameLabel setFont:[UIFont fontWithName:@"Avenir" size:30]];
    [self.parallaxHeaderTourNameLabel sizeToFit];
    self.parallaxHeaderTourNameLabel.numberOfLines = 0;
    self.parallaxHeaderTourNameLabel.textColor = [UIColor whiteColor];
    self.parallaxHeaderTourNameLabel.backgroundColor = [UIColor clearColor];
    
    CGFloat titleLabelHeight = self.parallaxImageView.bounds.size.height / 10;
    [self.parallaxHeaderTourNameLabel setFrame:CGRectMake(0, self.parallaxImageView.frame.origin.y - titleLabelHeight, self.view.frame.size.width, titleLabelHeight)];
    
    self.theScrollViewThatHoldsAllTheOtherViews.parallaxView.delegate = self;
    // Do any additional setup after loading the view.
   
    
    UIView *viewToAddTitleLabelTo = [self parallaxTitleSuperview:[[[UIApplication sharedApplication] keyWindow] subviews][0]]; //(UIView*)([[[UIApplication sharedApplication] keyWindow] subviews][0]);
    [viewToAddTitleLabelTo addSubview:self.parallaxHeaderTourNameLabel];
    UITabBar *tabBar = [viewToAddTitleLabelTo subviews][1];
    [self.parallaxHeaderTourNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabBar.mas_top);
        make.width.equalTo(tabBar.mas_width);
        make.left.equalTo(tabBar.mas_left);
        make.height.equalTo(tabBar.mas_height);
    }];
    
    [viewToAddTitleLabelTo bringSubviewToFront:self.parallaxHeaderTourNameLabel];
    
    _originalDistanceFromBottomOfScreenToBottomOfParallaxImage =  [self.tourDescriptionNib.superview convertPoint:self.tourDescriptionNib.frame.origin toView:nil].y - ([self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y);
}

-(UIView*)parallaxTitleSuperview:(UIView*)view {
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:[UITabBar class]];
    }];
    if ([view.subviews count] == 0)
        return nil;
    NSArray *maybeTabBar = [view.subviews filteredArrayUsingPredicate:pred];
    if ([maybeTabBar count] == 1)
        return [maybeTabBar[0] superview];
    return [self parallaxTitleSuperview:view.subviews[0]];
}

- (void)tappedParrallaxImage {
    [UIView animateWithDuration:.25 animations:^{
        CGFloat width = self.theScrollViewThatHoldsAllTheOtherViews.bounds.size.width;
        self.theScrollViewThatHoldsAllTheOtherViews.contentOffset = CGPointMake(0, -width/2);
    } completion:^(BOOL finished) {
        CGPoint offset = self.theScrollViewThatHoldsAllTheOtherViews.contentOffset;
        [self.theScrollViewThatHoldsAllTheOtherViews setContentOffset:offset animated:NO];
    }];
}
- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    //if (_startIt && self.parallaxHeaderTourNameLabel.alpha <= .5 && !_initialSetup) {
        //[self selectFirstItemInCollectionView];
    //}
    [self setAlphaForParallaxTitleLabel];
}

- (void)setAlphaForParallaxTitleLabel {
    self.parallaxHeaderTourNameLabel.alpha = ([self.tourDescriptionNib.superview convertPoint:self.tourDescriptionNib.frame.origin toView:nil].y - ([self.parallaxHeaderTourNameLabel.superview convertPoint:self.parallaxHeaderTourNameLabel.frame.origin toView:nil].y + self.parallaxHeaderTourNameLabel.frame.size.height)) / _originalDistanceFromBottomOfScreenToBottomOfParallaxImage;
}


- (IBAction)bookTourButtonTapped:(id)sender {
    
    UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:@"bookTour" bundle:nil];;
    
    TRVBookTourTableViewController *destination = [destinationStoryboard instantiateInitialViewController];

    
    // pass it into confirm purchase Storyboard
    destination.destinationTour = self.tour;
    destination.destinationPFTour = self.PFTour;
    NSLog(@"THIS IS THE TOUR BEING PASSED %@", self.tour);
    // Alan can you check if this is right
    [self presentViewController:destination animated:YES completion:nil];
    
}

- (void)setStopPropertiesOnSelection:(TRVTourStop *)stop {
    self.tourStopImageView.image = stop.image;
    
    self.nameOfStop.numberOfLines = 0;
    CGRect frame = self.nameOfStop.frame;
    frame.size.width += 30;
    frame.size.height += 30;
    self.nameOfStop.frame = frame;
    self.nameOfStop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.nameOfStop.text = stop.descriptionOfEvent;
    
    NSLog(@"Description: %@", stop.descriptionOfEvent);


}


- (void)viewWillAppear:(BOOL)animated {
    self.parallaxHeaderTourNameLabel.hidden = NO;
    self.parallaxHeaderTourNameLabel.alpha = _savedAlphaValue;
}

- (void)selectFirstItemInCollectionView {
    NSIndexPath *indexPath = [self.tourStopCollectionView indexPathForItemAtPoint:CGPointMake(10, 10)];
    [self.tourStopCollectionView cellForItemAtIndexPath:indexPath];
    [self.tourStopCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.tourStopCollectionView.delegate collectionView:self.tourStopCollectionView didSelectItemAtIndexPath:indexPath];
    _initialSetup = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parallaxHeaderTourNameLabel.hidden = YES;
    _savedAlphaValue = self.parallaxHeaderTourNameLabel.alpha;
}

@end
