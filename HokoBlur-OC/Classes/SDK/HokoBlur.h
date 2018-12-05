//
// Created by HokoFly on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import "BlurEnum.h"

@protocol BlurProcessor;
@class BlurProcessorBuilder;

#define HokoBlur ([[EasyHokoBlur instance] scheme])

extern NSString *_Nonnull const kAsyncBlurErrorDomain;


@protocol HokoBlurChain <NSObject>
@property(nonatomic, copy, readonly) id <HokoBlurChain> (^mode)(BlurMode mode);
@property(nonatomic, copy, readonly) id <HokoBlurChain> (^radius)(NSInteger radius);
@property(nonatomic, copy, readonly) id <HokoBlurChain> (^sampleFactor)(CGFloat sampleFactor);
@property(nonatomic, copy, readonly) id <HokoBlurChain> (^forceCopy)(BOOL forceCopy);
@property(nonatomic, copy, readonly) id <HokoBlurChain> (^needUpscale)(BOOL needUpscale);
@property(nonatomic, copy, readonly) id <BlurProcessor> (^processor)(void);
@end


@interface EasyHokoBlur : NSObject

+ (instancetype)instance;

//reserve for multiple blur schemes
- (id<HokoBlurChain>)scheme;

@end
