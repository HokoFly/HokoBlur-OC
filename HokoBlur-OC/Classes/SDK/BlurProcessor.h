//
// Created by HokoFly on 2018/11/23.
//

#import <Foundation/Foundation.h>
#import "BlurEnum.h"

@class BlurResult;

typedef void(^BlurCompletionHandler)(BlurResult *_Nonnull);


@protocol BlurProcessor <NSObject>

@required

@property(nonatomic, assign) BlurMode mode;
@property(nonatomic, assign) NSInteger radius;
@property(nonatomic, assign) CGFloat sampleFactor;
@property(nonatomic, assign) BOOL forceCopy;
@property(nonatomic, assign) BOOL needUpscale;
@property(nonatomic, copy, readonly, nonnull) UIImage *_Nonnull (^ blur)(UIImage *_Nonnull);
@property(nonatomic, copy, readonly, nonnull) void (^ asyncBlur)(UIImage *_Nonnull, BlurCompletionHandler _Nonnull);

@end
