#import "ThreadSelfManager.h"
#import "RNThreadsBridge.h"
@implementation ThreadSelfManager {
    RCTBridge *parentBridge;
}



@synthesize bridge = _bridge;
@synthesize threadId = _threadId;

RCT_EXPORT_MODULE(ThreadSelfManager);

RCT_EXPORT_METHOD(postMessage: (NSString *)message)
{
   parentBridge =  [RNThreadsBridge sharedInstance].getReactBridge;
   if (parentBridge == nil) {
         NSLog(@"No parent bridge defined - abord sending thread message");
         return;
    }
  NSLog(@"Posting self thread message: %@", self);
  NSString *eventName = [NSString stringWithFormat:@"Thread%@", self.threadId];
  [parentBridge.eventDispatcher sendAppEventWithName:eventName
                                                    body:message];
}

@end
