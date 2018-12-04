//
// Created by HokoFly on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import "BlurMode.h"

@protocol BlurProcessor;
@class BlurProcessorBuilder;

#define HokoBlur ([EasyHokoBlur instance])

@interface EasyHokoBlur : NSObject

@property(nonatomic, strong) BlurProcessorBuilder *builder;
@property(nonatomic, copy, readonly) EasyHokoBlur * (^mode)(BlurMode mode);
@property(nonatomic, copy, readonly) EasyHokoBlur * (^radius)(NSInteger radius);
@property(nonatomic, copy, readonly) EasyHokoBlur * (^sampleFactor)(CGFloat sampleFactor);
@property(nonatomic, copy, readonly) EasyHokoBlur * (^forceCopy)(BOOL forceCopy);
@property(nonatomic, copy, readonly) EasyHokoBlur * (^needUpscale)(BOOL needUpscale);
@property(nonatomic, copy, readonly) id<BlurProcessor> (^processor)(void);

+(instancetype)instance;

@end
