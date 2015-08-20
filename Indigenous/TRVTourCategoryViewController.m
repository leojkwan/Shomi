//
//  TRVTourCategoryViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourCategoryViewController.h"
#import "TRVTourCategoryCollectionViewCell.h"
#import "TRVTourCategoryView.h"
#import <Masonry.h>
#import "TRVUserDataStore.h"
#import "TRVGuideResultsTableViewController.h"


@interface TRVTourCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (nonatomic, strong) NSMutableArray *tourCategories;
@property (nonatomic, strong) TRVUserDataStore *dataStore;

@end

@implementation TRVTourCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [TRVUserDataStore sharedUserInfoDataStore];

    // Set Transparency
    
    [self.navigationController setNavigationBarHidden:NO];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault]; //
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];

    // make self as datasource and delegate
    self.categoryCollectionView.delegate =self;
    self.categoryCollectionView.dataSource = self;
//    [self dismissViewIfCategoryNotSelected];


    self.tourCategories = [[NSMutableArray alloc] initWithObjects:[TRVTourCategory returnCategoryWithTitle:@"See"],
                                                                                                                [TRVTourCategory returnCategoryWithTitle:@"Discover"],
                                                                                                                [TRVTourCategory returnCategoryWithTitle:@"Eat"],
                                                                                                                [TRVTourCategory returnCategoryWithTitle:@"Drink"], nil];
    
    NSLog(@"Selected city is: %@", self.selectedCity);

}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return array count
    return self.tourCategories.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVTourCategoryCollectionViewCell *cell = (TRVTourCategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"tourCategoryCollectionCell" forIndexPath:indexPath];
    TRVTourCategory *categoryForThisCell = [self.tourCategories objectAtIndex:indexPath.row];
    cell.categoryView.layer.cornerRadius = 3;
    cell.categoryView.layer.borderColor = [UIColor grayColor].CGColor;
    cell.categoryView.layer.borderWidth = 1;

    //OVERRIDE SETTER THAT SETS LABELS TO NIB
    
    [cell.categoryView setCategoryForThisView:categoryForThisCell];

    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
//    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    NSLog(@"ARE YOU GETTING CALLED IN THE DID SELECT ITEM?");
    self.dataStore.currentCategorySearching = self.tourCategories[indexPath.row];
    
//    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"showResultsSegue" sender:nil];
//    }];
    
    
}


#pragma mark - UICollectionViewLayout

// Set size of collection cell
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 160);
}


// set vertical seperation of cell
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15.0;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    // padding really
    return UIEdgeInsetsMake(10,10,10,10);  // top, left, bottom, right
}

// methods to dismiss modal
//-(void) dismissViewIfCategoryNotSelected {
//    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissModal:)];
//    tapGesture.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tapGesture];
//}

////
//
//    -(void)dismissModal:(UITapGestureRecognizer *)sender {
//        
//        CGPoint point = [sender locationInView:sender.view];
//        UIView *viewTouched = [sender.view hitTest:point withEvent:nil];
//        if ([viewTouched isKindOfClass:[TRVTourCategoryCollectionViewCell class]]) {
//            [self performSegueWithIdentifier:@"showResultsSegue" sender:nil];
//        } else {
//                            NSLog(@"NOT TOUCHING BUTTON");
//                            [self dismissViewControllerAnimated:YES completion:^{
//                            }];
//        }
//        
//    }

//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if (touch.view != self.view) { // accept only touchs on superview, not accept touchs on subviews
//        NSLog(@"TOUCHING BUTTON");
//        return NO;
//    }
//    NSLog(@"NOT TOUCHING BUTTON");
//    return YES;
//}
//

- (IBAction)dismissButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    NSArray *ip = [self.categoryCollectionView indexPathsForSelectedItems];
    TRVGuideResultsTableViewController *destination = [segue destinationViewController];
    destination.selectedCity = self.selectedCity;
    
    if([segue.identifier isEqualToString:@"entrySegue"]) {
        
       /// pass over filters..
    }
}

@end
