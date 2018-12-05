//
// Created by HokoFly on 2018/12/5.
// Copyright (c) 2018 HokoFly. All rights reserved.
//

#import "BlurResultDispatcher.h"
#import "BlurResult.h"

#pragma -mark BlurResultDelegateCaller

@interface BlurResultDelegateCaller : NSObject

@property(nonatomic, strong) BlurResult *result;

- (instancetype)initWithResult:(BlurResult *)result;

- (void)call;

@end

@implementation BlurResultDelegateCaller
- (instancetype)initWithResult:(BlurResult *)result {
    self = [super init];
    if (self) {
        self.result = result;
    }

    return self;
}


- (void)call {
    BlurResult *result = self.result;
    if (result) {
        if (result.completionHandler) {
            result.completionHandler(result);
        }
    }
}

@end

#pragma -mark BlurResultDispatcherImpl

@implementation BlurResultDispatcherImpl

- (instancetype)initWithDispatchQueue:(dispatch_queue_t)dispatchQueue {
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatchQueue;
    }

    return self;
}


- (void)dispatch:(BlurResult *)result {
    if (self.dispatchQueue) {
        dispatch_async(self.dispatchQueue, ^{
            [[[BlurResultDelegateCaller alloc] initWithResult:result] call];
        });
    }
}

@end