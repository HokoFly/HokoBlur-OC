//
// Created by HokoFly on 2018/11/23.
//

#import <Foundation/Foundation.h>
#import "BlurMode.h"

@protocol BlurProcessor <NSObject>

@required

@property(nonatomic, assign) BlurMode mode;
@property(nonatomic, assign) NSInteger radius;
@property(nonatomic, assign) CGFloat sampleFactor;
@property(nonatomic, assign) BOOL forceCopy;
@property(nonatomic, assign) BOOL needUpscale;

- (UIImage *) blur:(UIImage *)image;

@end