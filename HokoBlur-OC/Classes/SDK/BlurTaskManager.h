//
// Created by HokoFly on 2018/12/4.
//

#import <Foundation/Foundation.h>

@class BlurSubTask;


@interface BlurTaskManager : NSObject

@property(nonatomic, readonly) NSUInteger workersNum;
@property(nonatomic, readonly, strong) dispatch_queue_t parallelBlurQueue;

+(instancetype)instance;
-(void)invokeAll:(NSArray<BlurSubTask *> *)tasks;
@end