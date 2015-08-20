//
//  TRVTourStopCollectionViewDelegateFlowLayout.h
//  Indigenous
//
//  Created by Daniel Wickes on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRVTouristTripDetailViewController.h"

@protocol TourStopInfoDelegate
@required
-(void)setStopPropertiesOnSelection:(TRVTourStop*)stop;

@end


@interface TRVTourStopCollectionViewDelegateFlowLayout : NSObject <UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<TourStopInfoDelegate> delegate;
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
