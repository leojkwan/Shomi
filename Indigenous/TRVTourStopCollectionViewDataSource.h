//
//  TRVTourStopCollectionViewDataSource.h
//  Indigenous
//
//  Created by Daniel Wickes on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TRVTourStop;

@interface TRVTourStopCollectionViewDataSource : NSObject <UICollectionViewDataSource>

-(instancetype)initWithStops:(NSArray*)stops configuration:(void (^)(TRVTourStop*))configureCell;

@end
