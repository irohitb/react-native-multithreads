//
//  ThreadHandler.m
//  RNThread
//
//  Created by Rohit (Personal) on 24/01/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

#import "RNThreadHandler.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTDevSettings.h>

@implementation RNThreadHandler {
    NSMutableDictionary *threadsMap;
}


- (instancetype)init {
    if (self = [super init]) {
        //Initalizing Empty Participants
        threadsMap = [NSMutableDictionary new];
    }
    return self;
}

+ (instancetype)sharedInstance {
      static RNThreadHandler *sharedInstance = nil;
      static dispatch_once_t ThreadsOnceToken;
      dispatch_once(&ThreadsOnceToken, ^{
          sharedInstance = [[self alloc] init];
      });
      return sharedInstance;
}

- (BOOL)doesThreadWithIdExist:(NSString*)id {
    // Tells position in  hashmap
    if ([threadsMap valueForKey: id]) {
        return true;
    } else {
        // like JS if it doesn't exist in array, return -1
        return false;
    }
}

- (void)startNewThread:(NSString*_Nonnull)path threadId:(NSString *_Nonnull)threadId {
    // Don't start a thread with same id
    if ([self doesThreadWithIdExist:threadId] == false) {
        NSURL *threadURL = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:path];
        RCTBridge *threadBridge = [[RCTBridge alloc] initWithBundleURL:threadURL
                                                   moduleProvider:nil
                                                    launchOptions:nil];
        NSString *moduleName = [NSString stringWithFormat: @"ThreadSelfManager"];
        ThreadSelfManager *threadSelf = [threadBridge moduleForName:moduleName];
        [threadSelf setThreadId:threadId];
        [threadsMap setObject:threadBridge forKey:threadId];
    }
}

- (NSMutableDictionary *)getAllThreadsWithId {
    return threadsMap;
}

- (void)stopThread:(NSString *_Nonnull)threadId {
    if ([self doesThreadWithIdExist:threadId] != true) {
        RCTBridge *threadBridge = [threadsMap objectForKey:threadId];
        [threadBridge invalidate];
        [threadsMap removeObjectForKey:threadId];
    }
}
- (void)postThreadMessage: (NSString *_Nonnull)threadId message:(NSString *)message {
    RCTBridge *threadBridge = [threadsMap objectForKey:threadId];
    [threadBridge.eventDispatcher sendAppEventWithName:@"ThreadMessage"
                                                body:message];
}
- (void)invalidateAllThread {
        for(NSString* key in threadsMap) {
            RCTBridge *thread = threadsMap[key];
            [thread invalidate];
        }
        [threadsMap removeAllObjects];
}

@end

