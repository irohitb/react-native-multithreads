//
//  DyteSdk.m
//  dyteClientMobile
//
//  Created by Rohit Bhatia on 6/11/21.
//

#import "RNThreadsBridge.h"
#import "RNThreadMessageQueue.h"
#import "RNThreadHandler.h"

@implementation RNThreadsBridge {
  // These are probably suppose to private and hence we don't need to declare them in header file
  RCTBridge *_bridgeWrapper;

}



+ (instancetype)sharedInstance {
     static RNThreadsBridge *sharedInstance = nil;
     static dispatch_once_t BridgeOnceToken;
    dispatch_once(&BridgeOnceToken, ^{
          sharedInstance = [[self alloc] init];
    });
  return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        //Initalizing Empty Participants
    }
    return self;
}

- (RCTBridge *)getReactBridge {
    return _bridgeWrapper;
}

- (void)setReactBridge:(RCTBridge*)bridge  {
    _bridgeWrapper = bridge;
  }

- (void) invalidateBridge {
    if (_bridgeWrapper) {
        [_bridgeWrapper invalidate];
    }
    _bridgeWrapper = nil;
}

@end

