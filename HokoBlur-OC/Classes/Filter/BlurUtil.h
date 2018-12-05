//
//  BlurUtil.h
//
//  Created by HokoFly on 2018/11/22.
//
#ifndef HOKO_BLUR_UTIL_H
#define HOKO_BLUR_UTIL_H

namespace hokoblur {
    enum Direction {
        HORIZONTAL,
        VERTICAL,
        BOTH
    };

    int clamp(int i, int minValue, int maxValue);
}

#endif //HOKO_BLUR_UTIL_H
