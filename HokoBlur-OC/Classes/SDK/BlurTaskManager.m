//
// Created by HokoFly on 2018/12/4.
//

#import "BlurTaskManager.h"
#import "BlurSubTask.h"
#import <sys/sysctl.h>


@interface BlurTaskManager () {

}

@property(nonatomic, assign) NSUInteger workersNum;
@property(nonatomic, strong) dispatch_queue_t parallelBlurQueue;
@property(nonatomic, strong) dispatch_queue_t asyncBlurQueue;

@end

@implementation BlurTaskManager {

}


+ (instancetype)instance {
    static BlurTaskManager *blurTaskManager = nil;
    static dispatch_once_t manager_once_token;
    dispatch_once(&manager_once_token, ^{
        blurTaskManager = [[BlurTaskManager alloc] init];
    });

    return blurTaskManager;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.workersNum = [self getProcessorCount];
        self.parallelBlurQueue = dispatch_queue_create("com.hoko.blur.parallel.queue", DISPATCH_QUEUE_CONCURRENT);
        self.asyncBlurQueue = dispatch_queue_create("com.hoko.blur.async.queue", DISPATCH_QUEUE_CONCURRENT);
    }

    return self;
}

- (NSUInteger)getProcessorCount {
    NSUInteger ncpu;
    size_t len = sizeof(ncpu);
    sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
    return ncpu;
}

- (void)submit:(id <RunnableTask>)task {
    dispatch_async(self.asyncBlurQueue, ^{
        [task run];
    });
}

- (void)invokeAll:(NSArray<id <RunnableTask>> *)tasks {
    dispatch_group_t group = dispatch_group_create();
    for (id <RunnableTask> task in tasks) {
        dispatch_group_async(group, self.parallelBlurQueue, ^{
            [task run];
        });
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
