#ifndef ThreadSelfManager_h
#define ThreadSelfManager_h

#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTBundleURLProvider.h>


@interface ThreadSelfManager : NSObject <RCTBridgeModule>
@property NSString* threadId;
@end

#endif
