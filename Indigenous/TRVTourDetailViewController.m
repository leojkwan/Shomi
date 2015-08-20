//
//  TRVTourDetailViewController.m
//  Indigenous
//
//  Created by Leo Kwan on 8/10/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourDetailViewController.h"
#import "TRVDetailGuideViewController.h"
#import "TRVTourReceiptViewController.h"
#import "TRVAllStopsView.h"
#import "TRVTourView.h"
#import <Masonry.h>
#import "TRVTouristTripDetailViewController.h"

@interface TRVTourDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *VCScrollView;
@property (weak, nonatomic) IBOutlet UIView *VCContentView;

@end
//
@implementation TRVTourDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
//    TRVTourView *selectedTourView = [[TRVTourView alloc] init];
//    selectedTourView.tourForThisTourView = self.destinationTour;
//    [self.VCContentView addSubview:selectedTourView];
//    [self.VCContentView removeConstraints:self.VCContentView.constraints];
//    [selectedTourView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.left.and.right.equalTo(self.VCContentView);
//    }];
//    
//    TRVAllStopsView *allStopsScrollNib = [[TRVAllStopsView alloc] init];
//    allStopsScrollNib.tourForThisScrollNib = self.destinationTour;
//    [self.VCContentView addSubview:allStopsScrollNib];
//  [allStopsScrollNib mas_makeConstraints:^(MASConstraintMaker *make) {
//      make.top.equalTo(selectedTourView.mas_bottom);
//      make.height.equalTo(@400);
//      make.left.and.right.equalTo(self.VCContentView);
//  }];
//    
//    // Add Tour Button
//    UIButton *bookTourButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    bookTourButton.backgroundColor = [UIColor magentaColor];
//    [bookTourButton setTitle:@"Book Tour" forState:UIControlStateNormal];
//    [bookTourButton addTarget:self action:@selector(bookTourButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.VCContentView addSubview:bookTourButton];
//    [bookTourButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.VCContentView.mas_centerX);
//        make.height.equalTo(@100);
//        make.width.equalTo(self.VCContentView.mas_width).dividedBy(1.5);
//        
//        //add top padding
//        make.top.equalTo(allStopsScrollNib.mas_bottom).with.offset(50);
//    }];
//    
//    
//    
//    [self.VCContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        // add bottom padding
//        make.bottom.equalTo(bookTourButton.mas_bottom).with.offset(50);
//    }];

}
//    
//
//-(void)bookTourButtonPressed:(id)sender {
//    
//        UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:@"bookTour" bundle:nil];;
//    
//        TRVBookTourViewController *destination = [destinationStoryboard instantiateInitialViewController];
//    
//    // pass it into confirm purchase Storyboard
//    destination.destinationTour = self.destinationTour;
//    
//        // Alan can you check if this is right
//        [self presentViewController:destination animated:NO completion:nil];
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
