#import <Foundation/Foundation.h>
#import "ThreadSelfManager.h"
#import <React/RCTDevSettings.h>
#import <React/RCTBridge.h>

@interface RNThreadHandler : NSObject
@property(nonatomic, readonly) NSMutableDictionary* _Nonnull threadsMap;
- (void)startNewThread:(NSString*_Nonnull)path threadId:(NSString *_Nonnull)threadId;
- (void)stopThread:(NSString *_Nonnull)threadId;
- (void)postThreadMessage:(NSString *_Nonnull)threadId message:(NSString *)message;
- (void)invalidateAllThread;
- (BOOL)doesThreadWithIdExist:(NSString*)id;
- (NSMutableDictionary *)getAllThreadsWithId;
+ (instancetype _Nonnull)sharedInstance;
@end
