#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BlurUtil.h"
#import "BoxBlurFilter.h"
#import "StackBlurFilter.h"
#import "BlurFilter.h"
#import "UIImage+PixelsData.h"

FOUNDATION_EXPORT double HokoBlur_OCVersionNumber;
FOUNDATION_EXPORT const unsigned char HokoBlur_OCVersionString[];

