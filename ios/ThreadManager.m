#import "ThreadManager.h"
#import "RNThreadHandler.h"
#import "RNThreadsBridge.h"
#include <stdlib.h>

@implementation ThreadManager {
    RNThreadHandler* _threadHandler;
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(ThreadManager);

RCT_EXPORT_METHOD(startThread: (NSString *)path
                  threadId: (NSString*)threadId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTBridge* parentBridge =  [RNThreadsBridge sharedInstance].getReactBridge;
    if (parentBridge == nil) {
        [[RNThreadsBridge sharedInstance] setReactBridge:self.bridge];
    }
    [[RNThreadHandler sharedInstance] startNewThread:path threadId:threadId];
    resolve(threadId);
}

RCT_EXPORT_METHOD(getExistingThread:
                  (NSString*)threadId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{

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

- (void)invalidate {
    [[RNThreadHandler sharedInstance] invalidateAllThread];
    [[RNThreadsBridge sharedInstance] invalidateBridge];
}

@end
