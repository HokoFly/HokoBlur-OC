#include <stdlib.h>
#include "BlurUtil.h"

#ifndef HOKO_BLUR_BOXBLURFILTER_H
#define HOKO_BLUR_BOXBLURFILTER_H

void boxBlur(int *pixels, int radius, int cores, int index, int direction, int w, int h);

#endif
