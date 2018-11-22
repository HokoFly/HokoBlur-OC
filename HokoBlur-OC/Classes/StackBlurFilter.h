//
//  StackBlurFilter.h
//
//  Created by HokoFly on 2018/11/22.
//

#include <stdio.h>
#include <stdlib.h>
#import "BlurUtil.h"

#ifndef HOKO_BLUR_STACKBLURFILTER_H
#define HOKO_BLUR_STACKBLURFILTER_H

#define max(a, b) ((a)>(b)?(a):(b))
#define min(a, b) ((a)<(b)?(a):(b))

void stackBlur(int *pixels, int j_radius, int j_cores, int j_index, int j_direction, int w, int h);

#endif
