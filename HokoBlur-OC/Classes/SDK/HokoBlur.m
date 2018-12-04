//
// Created by HokoFly on 2018/12/4.
//

#import "HokoBlur.h"
#import "BlurProcessor.h"
#import "AbstractBlurProcessor.h"
#import "DefaultBlurProcessor.h"


@implementation EasyHokoBlur {

}
+ (instancetype)instance {

    static EasyHokoBlur *sInstance = nil;
    static dispatch_once_t hoko_blur_once_token;
    dispatch_once(&hoko_blur_once_token, ^{
        sInstance = [[EasyHokoBlur alloc] init];
    });

    sInstance.builder = [[BlurProcessorBuilder alloc] init];
    return sInstance;
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.builder = [[BlurProcessorBuilder alloc] init];
//    }
//
//    return self;
//}


- (EasyHokoBlur *(^)(BlurMode))mode {
    return ^EasyHokoBlur *(BlurMode mode) {
        self.builder.mode = mode;
        return self;
    };
}

- (EasyHokoBlur *(^)(NSInteger))radius {
    return ^EasyHokoBlur *(NSInteger radius) {
        self.builder.radius = radius;
        return self;
    };
}

- (EasyHokoBlur *(^)(CGFloat))sampleFactor {
    return ^EasyHokoBlur *(CGFloat sampleFactor) {
        self.builder.sampleFactor = sampleFactor;
        return self;
    };
}

- (EasyHokoBlur *(^)(BOOL))forceCopy {
    return ^EasyHokoBlur *(BOOL forceCopy) {
        self.builder.forceCopy = forceCopy;
        return self;
    };
}

- (EasyHokoBlur *(^)(BOOL))needUpscale {
    return ^EasyHokoBlur *(BOOL needUpscale) {
        self.builder.needUpscale = needUpscale;
        return self;
    };
}

- (id <BlurProcessor> (^)(void))processor {
    return ^id <BlurProcessor> {
        id <BlurProcessor> blurProcessor = [[DefaultBlurProcessor alloc] initWithBuilder:self.builder];
        return blurProcessor;
    };
}


@end