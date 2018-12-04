//
// Created by HokoFly on 2018/12/4.
//

#import "HokoBlur.h"
#import "BlurProcessor.h"
#import "AbstractBlurProcessor.h"
#import "DefaultBlurProcessor.h"


@interface HokoBlurChainImpl : NSObject <HokoBlurChain>
@property(nonatomic, strong) BlurProcessorBuilder *builder;

@end


@implementation HokoBlurChainImpl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.builder = [[BlurProcessorBuilder alloc] init];
    }

    return self;
}


- (id <HokoBlurChain> (^)(BlurMode))mode {
    return ^id <HokoBlurChain> (BlurMode mode) {
        self.builder.mode = mode;
        return self;
    };
}

- (id <HokoBlurChain> (^)(NSInteger))radius {
    return ^id <HokoBlurChain> (NSInteger radius) {
        self.builder.radius = radius;
        return self;
    };
}

- (id <HokoBlurChain> (^)(CGFloat))sampleFactor {
    return ^id <HokoBlurChain> (CGFloat sampleFactor) {
        self.builder.sampleFactor = sampleFactor;
        return self;
    };
}

- (id <HokoBlurChain> (^)(BOOL))forceCopy {
    return ^id <HokoBlurChain> (BOOL forceCopy) {
        self.builder.forceCopy = forceCopy;
        return self;
    };
}

- (id <HokoBlurChain> (^)(BOOL))needUpscale {
    return ^id <HokoBlurChain> (BOOL needUpscale) {
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



@implementation EasyHokoBlur {

}
+ (instancetype)instance {

    static EasyHokoBlur *sInstance = nil;
    static dispatch_once_t hoko_blur_once_token;
    dispatch_once(&hoko_blur_once_token, ^{
        sInstance = [[EasyHokoBlur alloc] init];
    });

    return sInstance;
}

- (id<HokoBlurChain>)scheme {
    return [[HokoBlurChainImpl alloc] init];
}


@end