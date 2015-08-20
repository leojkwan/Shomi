//
//  TRVTourStopCollectionViewDelegateFlowLayout.m
//  Indigenous
//
//  Created by Daniel Wickes on 8/3/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVTourStopCollectionViewDelegateFlowLayout.h"
#import "TRVTourStopCollectionViewCell.h"
#import "TRVTourStop.h"

@implementation TRVTourStopCollectionViewDelegateFlowLayout 

//-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    //cell.bounds = CGRectInset(cell.frame, 10, 10);
//    //CGFloat width = collectionView.bounds.size.width / 10;
//    //CGSize bounds = CGSizeMake(width, collectionView.bounds.size.height);
//    
//    //return bounds;
//}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRVTourStopCollectionViewCell *cell = (TRVTourStopCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    __weak TRVTourStopCollectionViewDelegateFlowLayout *weakSelf = self;
    [cell selectionAnimation:^{
        [weakSelf.delegate setStopPropertiesOnSelection:cell.stop];
    }];
    
    //[self.delegate setStopPropertiesOnSelection:cell.stop];
    NSLog(@"Selected cell's bounds: %@", NSStringFromCGRect(cell.bounds));
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRVTourStopCollectionViewCell *cell = (TRVTourStopCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell deselectionAnimation];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.x==0) {
        UICollectionView *cv = (UICollectionView*)scrollView;
        //UIView *cell = [cv cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        *targetContentOffset = scrollView.contentOffset; // set acceleration to 0.0
        CGFloat cellWidth = cv.bounds.size.width / 10;
        
        int cellToSwipe = (scrollView.contentOffset.x)/(cellWidth); // cell width + min spacing for lines
        if (cellToSwipe < 0) {
            cellToSwipe = 0;
        } else if (cellToSwipe >= 50) {
            cellToSwipe = 50 - 1;
        }
        
        [cv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        NSLog(@"Dragging");
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UICollectionView *cv = (UICollectionView*)scrollView;
    //UIView *cell = [cv cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //*targetContentOffset = scrollView.contentOffset; // set acceleration to 0.0
    CGFloat cellWidth = cv.bounds.size.width / 10;
    
    int cellToSwipe = (scrollView.contentOffset.x)/(cellWidth); // cell width + min spacing for lines
    if (cellToSwipe < 0) {
        cellToSwipe = 0;
    } else if (cellToSwipe >= 50) {
        cellToSwipe = 50 - 1;
    }
    
    [cv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    NSLog(@"help");
}

@end
