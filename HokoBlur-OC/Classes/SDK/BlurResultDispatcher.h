//
// Created by HokoFly on 2018/12/5.
//

#import <Foundation/Foundation.h>

@class BlurResult;

@protocol BlurResultDispatcher <NSObject>
@required
- (void)dispatch:(BlurResult *)result;
@end

@interface BlurResultDispatcherImpl : NSObject <BlurResultDispatcher>

@property(nonatomic, strong) dispatch_queue_t dispatchQueue;

- (instancetype)initWithDispatchQueue:(dispatch_queue_t)dispatchQueue;

@end

id<BlurResultDispatcher> mainThreadDispatcher(void);

