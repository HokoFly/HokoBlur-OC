#include <Foundation/Foundation.h>

//
//  BlurEnum.h
//  Pods
//
//  Created by HokoFly on 2018/11/29.
//
typedef NS_ENUM(NSUInteger, BlurMode) {
    BLUR_MODE_BOX = 0,
    BLUR_MODE_GAUSSIAN = 1,
    BLUR_MODE_STACK = 2,
};

typedef NS_ENUM(NSUInteger, BlurDirection) {
    DIRECTION_HORIZONTAL = 0,
    DIRECTION_VERTICAL = 1,
    DIRECTION_BOTH = 2,
};

typedef NS_ENUM(NSUInteger, BlurErrorCode) {
    HokoBlurErroCodeNoProcessor = 100,
    HokoBlurErroCodeProcessFailed = 101,
};


