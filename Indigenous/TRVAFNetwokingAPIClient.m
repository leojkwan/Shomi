//
//  TRVAFNetwokingAPIClient.m
//  Indigenous
//
//  Created by Leo Kwan on 7/31/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVAFNetwokingAPIClient.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@implementation TRVAFNetwokingAPIClient

+(void)getImagesWithURL:(NSString *)URL withCompletionBlock:(void (^) (UIImage *response)) completionBlock {
    
    NSURL *imageURL = [NSURL URLWithString:URL];
    NSURLRequest *imageURLRequest = [NSURLRequest requestWithURL:imageURL];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:imageURLRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];

}



@end
