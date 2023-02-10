#import "ThreadManager.h"
#import "RNThreadHandler.h"
#import "RNThreadsBridge.h"
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNThreadSpec.h"
#endif
#include <stdlib.h>

@implementation ThreadManager {
    RNThreadHandler* _threadHandler;
}

@synthesize bridge = _bridge;


RCT_EXPORT_MODULE(ThreadManager);

- (void) initalizeBridge {
    RCTBridge* parentBridge =  [RNThreadsBridge sharedInstance].getReactBridge;
    if (parentBridge == nil) {
        [[RNThreadsBridge sharedInstance] setReactBridge:self.bridge];
    }
}
RCT_EXPORT_METHOD(startThread: (NSString *)path
                  threadId: (NSString*)threadId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    [self initalizeBridge];
    [[RNThreadHandler sharedInstance] startNewThread:path threadId:threadId];
    resolve(threadId);
}

RCT_EXPORT_METHOD(getExistingThread:
                  (NSString*)threadId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    [self initalizeBridge];
    if ([[RNThreadHandler sharedInstance] doesThreadWithIdExist:threadId] == true) {
        resolve(threadId);
    } else {
        reject(@"Error", [NSString stringWithFormat:@"Thread ID does not exist '%@'", threadId], nil);

    }
}

RCT_EXPORT_METHOD(stopThread:(NSString*)threadId)
{
    [[RNThreadHandler sharedInstance] stopThread:threadId];
}

RCT_EXPORT_METHOD(getThreadsId:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {

    RNThreadHandler *threads = [RNThreadHandler sharedInstance];
    NSMutableDictionary *threadsMap = [threads getAllThreadsWithId];
    resolve(threadsMap);
}

RCT_EXPORT_METHOD(postThreadMessage: (NSString*)threadId message:(NSString *)message)
{
    [[RNThreadHandler sharedInstance] postThreadMessage:threadId message:message];
}

RCT_EXPORT_METHOD(getAllMessages:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    NSMutableDictionary* messages =[[RNThreadHandler sharedInstance] messages];
    resolve(messages);
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeCalculatorSpecJSI>(params);
}
#endif

- (void)invalidate {
    [[RNThreadHandler sharedInstance] invalidateAllThread];
    [[RNThreadsBridge sharedInstance] invalidateBridge];
}

@end
