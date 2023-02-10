#import <React/RCTBridge.h>
#import <React/RCTBridge+Private.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTBundleURLProvider.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import "RNThreadSpec.h"
@interface ThreadManager : NSObject <NativeThreadSpec>
#else

@interface ThreadManager : NSObject <RCTBridgeModule>
#endif

@end
