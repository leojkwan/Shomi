//
//  TRVTourStopCollectionViewDataSource.m
//  Indigenous
//
//  Created by Daniel Wickes on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewDataSource.h"
#import "TRVTourStop.h"
#import "TRVTourStopCollectionViewCell.h"

@implementation TRVTourStopCollectionViewDataSource {
    NSArray *_stops;
    void (^_configureCell)(TRVTourStop*);
}

-(instancetype)initWithStops:(NSArray*)stops configuration:(void (^)(TRVTourStop*))configureCell {
    if (self = [super init]) {
        _stops = stops;
        _configureCell = configureCell;
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_stops count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRVTourStopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tourStopCell" forIndexPath:indexPath];
    cell.stop = _stops[indexPath.row];
    cell.numStop.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    //NSLog(@"Cell's frame: %@", NSStringFromCGRect(cell.frame));
    //_configureCell(_stops[indexPath.row]);
    return cell;
}

@end
