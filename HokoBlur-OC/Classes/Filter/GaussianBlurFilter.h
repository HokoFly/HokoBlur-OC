//
// Created by HokoFly on 16/9/10.
//

#ifndef HOKO_BLUR_GAUSSIANBLURFILTER_H
#define HOKO_BLUR_GAUSSIANBLURFILTER_H


#include <stdlib.h>
#include "math.h"
#include "BlurUtil.h"

void gaussianBlur(int *pixels, int radius, int cores, int index, int direction, int w, int h);

#endif //HOKO_BLUR_GAUSSIANBLURFILTER_H
