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
@property(nonatomic, copy, readonly, nonnull) UIImage *_Nonnull (^ blur)(UIImage *_Nonnull);
@property(nonatomic, copy, readonly, nonnull) void (^ asyncBlur)(UIImage *_Nonnull, BlurCompletionHandler _Nonnull);

- (NSData *_Nonnull)blurWithData:(NSData *_Nonnull)data width:(NSInteger)w height:(NSInteger)h inParallel:(BOOL)parallel;

- (instancetype _Nonnull)init;

- (instancetype _Nonnull)initWithBuilder:(BlurProcessorBuilder *_Nonnull)builder;

+ (instancetype _Nonnull)makeWithBuilder:(void (^ _Nonnull)(BlurProcessorBuilder *_Nonnull))updateBlock;

- (instancetype _Nonnull)update:(void (^ _Nonnull)(BlurProcessorBuilder *_Nonnull))updateBlock;

@end
