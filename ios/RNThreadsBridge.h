#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNThreadsBridge : NSObject
- (RCTBridge *)getReactBridge;
+ (instancetype _Nonnull)sharedInstance;
- (RCTBridge*)setReactBridge;
- (void)setReactBridge:(RCTBridge*)bridge;
- (void)invalidateBridge;
@end

NS_ASSUME_NONNULL_END

