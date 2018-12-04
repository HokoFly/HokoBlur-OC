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
@property(nonatomic, copy, readonly) UIImage * (^blur)(UIImage *);

- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h;

- (instancetype)init;
- (instancetype)initWithBuilder:(BlurProcessorBuilder *)builder;
+ (instancetype)makeWithBuilder:(void (^)(BlurProcessorBuilder *))updateBlock;
- (instancetype)update:(void (^)(BlurProcessorBuilder *))updateBlock;

- (NSString *)description;

@end