//
// Created by HokoFly on 2018/12/4.
//

#import <Foundation/Foundation.h>

@class BlurSubTask;
@protocol RunnableTask;


@interface BlurTaskManager : NSObject

@property(nonatomic, readonly) NSUInteger workersNum;
@property(nonatomic, readonly, strong) dispatch_queue_t parallelBlurQueue;
@property(nonatomic, readonly, strong) dispatch_queue_t asyncBlurQueue;

+ (instancetype)instance;

- (dispatch_block_t)submit:(id <RunnableTask>)task;

- (void)invokeAll:(NSArray<id <RunnableTask>> *)tasks;
@end