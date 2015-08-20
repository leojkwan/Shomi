//
//  TRVFilterViewController.m
//  Indigenous
//
//  Created by Alan Scarpa on 8/4/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVFilterViewController.h"
#import "TRVUserDataStore.h"
#import "TRVSubCategoryCollectionView.h"
#import "TRVSubCategoryCollectionViewCell.h"





@interface TRVFilterViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIPickerView *pricePicker;
@property (nonatomic, strong) NSArray *prices;

@property (nonatomic, strong) NSString *priceFilter;

@property (nonatomic, strong) TRVUserDataStore *dataStore;

@property (weak, nonatomic) IBOutlet TRVSubCategoryCollectionView *subCategoryCollectionView;
@property (nonatomic, strong) NSArray *subCategories;
@property (nonatomic, strong) NSMutableArray *selectedSubCategories;
@end

@implementation TRVFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [TRVUserDataStore sharedUserInfoDataStore];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setUpSubCategories];
    [self setUpSubCategoryCollectionView];
    [self setUpPickerView];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}



-(void)setUpSubCategoryCollectionView {
    
    self.subCategoryCollectionView.delegate = self;
    self.subCategoryCollectionView.dataSource = self;
    self.subCategoryCollectionView.allowsMultipleSelection = YES;
    self.selectedSubCategories = [[NSMutableArray alloc]init];
}

-(void)setUpPickerView {
    
    self.prices = @[@"All Prices", @"$0 - $25", @"$26 - $50", @"$50 - $100"];
    self.pricePicker.dataSource = self;
    self.pricePicker.delegate = self;
    
    if(self.filterDictionary[@"price"]){
        NSInteger n = [self.prices indexOfObject:self.filterDictionary[@"price"]];
        [self.pricePicker selectRow:n inComponent:0 animated:YES];
        
        
        
    }
    
    NSInteger row = [self.pricePicker selectedRowInComponent:0];
    self.priceFilter = self.prices[row];
    
    
    
    
}

-(void)setUpSubCategories {
    
    NSLog(@"Category: %@", self.dataStore.currentCategorySearching);
    
    if ([self.dataStore.currentCategorySearching.categoryName isEqualToString:@"Eat"]){
        
        self.subCategories = @[@"Restaurant", @"Street Food", @"Snack", @"Breakfast", @"Brunch", @"Lunch", @"Dinner", @"Dessert", @"Other"];
        
        
    } else if ([self.dataStore.currentCategorySearching.categoryName isEqualToString:@"Drink"]){
        
        self.subCategories = @[@"Beer", @"Wine", @"Hard Liquor", @"Dive Bar", @"Upscale", @"Happy Hour"];
        
        
    } else if ([self.dataStore.currentCategorySearching.categoryName isEqualToString:@"Play"]){
        
        self.subCategories = @[@"Sports", @"Outdoors", @"Hiking", @"Biking", @"Swimming"];
        
        
    } else if ([self.dataStore.currentCategorySearching.categoryName isEqualToString:@"See"]){
        
        self.subCategories = @[@"Landmarks", @"Nature", @"History", @"Buildings"];
    }
    
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.subCategories.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TRVSubCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    cell.categoryLabel.text = self.subCategories[indexPath.row];
    
    if ([self.filterDictionary[@"subCategories"] containsObject:self.subCategories[indexPath.row]]){
        cell.backgroundColor = [UIColor magentaColor];
        [self.selectedSubCategories addObject:self.subCategories[indexPath.row]];
        
        
    }
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor magentaColor];
    
    [self.selectedSubCategories addObject:self.subCategories[indexPath.row]];
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    
    [self.selectedSubCategories removeObject:self.subCategories[indexPath.row]];
    
    
}



// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.prices.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.prices[row];
}



// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.priceFilter = self.prices[row];
    
    
}





- (IBAction)doneButtonPressed:(id)sender {
    //NSLog(@"Selected subs %@", self.selectedSubCategories);
    
    
    
    if ([self.priceFilter isEqualToString:@"All Prices"] && self.selectedSubCategories.count == 0){
        [self.delegate passFilterDictionary:nil];
    } else {
        [self.delegate passFilterDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                             self.priceFilter,@"price",
                                             self.selectedSubCategories, @"subCategories",
                                             nil]];
    }
    
   
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (IBAction)resetButtonPressed:(id)sender {
    
    
    //  self.dataStore.filterChoices = nil;
    [self.delegate passFilterDictionary:nil];
    self.filterDictionary = nil;
    self.selectedSubCategories = [@[] mutableCopy];
    [self.pricePicker selectRow:0 inComponent:0 animated:YES];
    self.priceFilter = self.prices[0];
    [self.subCategoryCollectionView reloadData];
    
    
    
}


- (IBAction)dismissButtonPressed:(id)sender {
    
    //    self.dataStore.filterChoices = nil;
    if ([self.priceFilter isEqualToString:@"All Prices"] && self.selectedSubCategories.count == 0){
        [self.delegate passFilterDictionary:nil];
    } else {
        [self.delegate passFilterDictionary:self.filterDictionary];
    }
    
    //    self.selectedSubCategories = [@[] mutableCopy];
    //    self.priceFilter = self.prices[0];
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