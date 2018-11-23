//
//  StackBlurFilter.h
//
//  Created by HokoFly on 2018/11/22.
//

#include <stdlib.h>
#import "BlurUtil.h"

#ifndef HOKO_BLUR_STACKBLURFILTER_H
#define HOKO_BLUR_STACKBLURFILTER_H

#define max(a, b) ((a)>(b)?(a):(b))
#define min(a, b) ((a)<(b)?(a):(b))

void stackBlur(uint32_t *pixels, int radius, int cores, int index, int direction, int w, int h);

#endif
