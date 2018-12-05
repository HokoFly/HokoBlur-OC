//
// Created by HokoFly on 2018/11/29.
//

#import <Foundation/Foundation.h>
#import "BlurProcessor.h"


@interface BlurProcessorBuilder : NSObject

@property(nonatomic, assign) BlurMode mode;
@property(nonatomic, assign) NSInteger radius;
@property(nonatomic, assign) CGFloat sampleFactor;
@property(nonatomic, assign) BOOL forceCopy;
@property(nonatomic, assign) BOOL needUpscale;

@end


@interface AbstractBlurProcessor : NSObject <BlurProcessor>

@property(nonatomic, assign) BlurMode mode;
@property(nonatomic, assign) NSInteger radius;
@property(nonatomic, assign) CGFloat sampleFactor;
@property(nonatomic, assign) BOOL forceCopy;
@property(nonatomic, assign) BOOL needUpscale;
@property(nonatomic, copy, readonly) UIImage *(^ blur)(UIImage *);
@property(nonatomic, copy, readonly) void (^ asyncBlur)(UIImage *, BlurCompletionHandler);

- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h inParallel:(BOOL)parallel;

- (instancetype)init;

- (instancetype)initWithBuilder:(BlurProcessorBuilder *)builder;

+ (instancetype)makeWithBuilder:(void (^)(BlurProcessorBuilder *))updateBlock;

- (instancetype)update:(void (^)(BlurProcessorBuilder *))updateBlock;

@end
