//
// Created by HokoFly on 2018/11/22.
//

#import "BlurFilter.h"
#import "GaussianBlurFilter.h"
#import "StackBlurFilter.h"
#import "BoxBlurFilter.h"


@implementation BlurFilter {

}

+ (NSData *)blur:(NSData *)data mode:(BlurMode)mode radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h {
    uint32_t *pixels = (uint32_t *) [data bytes];

    switch (mode) {
        case BLUR_MODE_BOX:
            boxBlur(pixels, r, 1, 0, hokoblur::HORIZONTAL, (int) w, (int) h);
            boxBlur(pixels, r, 1, 0, hokoblur::VERTICAL, (int) w, (int) h);
            break;
        case BLUR_MODE_STACK:
            stackBlur(pixels, r, 1, 0, hokoblur::HORIZONTAL, (int) w, (int) h);
            stackBlur(pixels, r, 1, 0, hokoblur::VERTICAL, (int) w, (int) h);
            break;
        case BLUR_MODE_GAUSSIAN:
            gaussianBlur(pixels, r, 1, 0, hokoblur::HORIZONTAL, (int) w, (int) h);
            gaussianBlur(pixels, r, 1, 0, hokoblur::VERTICAL, (int) w, (int) h);
            break;
    }

    NSData *result = [NSData dataWithBytes:pixels length:data.length];

    return result;
}

@end
