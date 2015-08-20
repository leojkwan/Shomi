//
//  TRVUserSignupHandler.h
//  Indigenous
//
//  Created by Alan Scarpa on 7/30/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRVUserSignupHandler : NSObject

+(void)addUserToParse:(NSDictionary*)userDetails withCompletion:(void (^)(BOOL success, NSError *error))completion;

@end
