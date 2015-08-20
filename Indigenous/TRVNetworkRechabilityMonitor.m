//
//  TRVNetworkRechabilityMonitor.m
//  Indigenous
//
//  Created by Leo Kwan on 8/9/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import "TRVNetworkRechabilityMonitor.h"
#import <AFNetworkReachabilityManager.h>

@implementation TRVNetworkRechabilityMonitor

+(void)startNetworkReachabilityMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - Check Internet Network Status
+(BOOL)checkNetworkStatus {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
