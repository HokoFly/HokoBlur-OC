//
// Created by HokoFly on 2018/12/5.
//

#import "AsyncBlurTask.h"
#import "BlurResultDispatcher.h"
#import "BlurResult.h"
#import "HokoBlur.h"


@implementation AsyncBlurTask {

}

- (instancetype)initWithDelegate:(BlurCompletionHandler)completionHandler processor:(id <BlurProcessor>)processor image:(UIImage *)image {
    self = [super init];
    if (self) {
        self.completionHandler = completionHandler;
        self.processor = processor;
        self.image = image;
        self.resultDispacher = mainThreadDispatcher();
    }

    return self;
}

+ (instancetype)taskWithDelegate:(BlurCompletionHandler)completionHandler processor:(id <BlurProcessor>)processor image:(UIImage *)image {
    return [[self alloc] initWithDelegate:completionHandler processor:processor image:image];
}

- (void)run {
    BlurResult *result = [[BlurResult alloc] initWithCompletionHandler:self.completionHandler];

    @try {
        if (self.processor) {
            result.image = self.processor.blur(self.image);
            result.success = YES;
        } else {
            result.success = NO;
            result.error = [NSError errorWithDomain:kAsyncBlurErrorDomain code:HokoBlurErroCodeNoProcessor userInfo:@{NSLocalizedFailureReasonErrorKey: @"No blur processor provided"}];
        }
    }

    @catch (NSException *exception) {
        result.success = NO;
        result.error = [NSError errorWithDomain:kAsyncBlurErrorDomain code:HokoBlurErroCodeProcessFailed userInfo:@{NSLocalizedFailureReasonErrorKey: exception.reason}];
    }

    @finally {
        [self.resultDispacher dispatch:result];
    }


}


@end