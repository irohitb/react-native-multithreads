#import <Foundation/Foundation.h>

@interface RNThreadMessageQueue : NSObject
@property(nonatomic) NSString* threadId;
@property(nonatomic) NSString* message;
@property(nonatomic) BOOL parentBridgeExisted;
@end
