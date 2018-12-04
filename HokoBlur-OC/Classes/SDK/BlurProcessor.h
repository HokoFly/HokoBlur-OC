//
// Created by HokoFly on 2018/11/23.
//

#import <Foundation/Foundation.h>
#import "BlurEnum.h"

@protocol BlurProcessor <NSObject>

@required

@property(nonatomic, assign) BlurMode mode;
@property(nonatomic, assign) NSInteger radius;
@property(nonatomic, assign) CGFloat sampleFactor;
@property(nonatomic, assign) BOOL forceCopy;
@property(nonatomic, assign) BOOL needUpscale;
@property(nonatomic, copy, readonly) UIImage * (^blur)(UIImage *);

//- (UIImage *) blur:(UIImage *)image;

@end