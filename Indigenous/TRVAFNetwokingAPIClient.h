//
//  TRVAFNetwokingAPIClient.h
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TRVAFNetwokingAPIClient : NSObject

+(void)getImagesWithURL:(NSString *)URL withCompletionBlock:(void (^) (UIImage *response)) completionBlock;



@end
