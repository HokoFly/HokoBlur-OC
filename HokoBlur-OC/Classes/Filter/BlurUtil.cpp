//
//  BlurUtil.cpp
//  HokoBlur-OC
//
//  Created by HokoFly on 2018/11/22.
//

#include "BlurUtil.h"


int hokoblur::clamp(int i, int minValue, int maxValue) {
    if (i < minValue) {
        return minValue;
    } else if (i > maxValue) {
        return maxValue;
    } else {
        return i;
    }
}
