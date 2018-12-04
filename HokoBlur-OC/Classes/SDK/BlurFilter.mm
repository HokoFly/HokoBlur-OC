//
// Created by HokoFly on 2018/11/22.
//

#import "BlurFilter.h"
#import "GaussianBlurFilter.h"
#import "StackBlurFilter.h"
#import "BoxBlurFilter.h"


@implementation BlurFilter {

}

+ (NSData *)blur:(NSData *)data mode:(BlurMode)mode radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h cores:(NSInteger)cores index:(NSInteger)index direction:(BlurDirection)direction {
    uint32_t *pixels = (uint32_t *) [data bytes];

    switch (mode) {
        case BLUR_MODE_BOX:
            boxBlur(pixels, r, cores, index, direction, (int) w, (int) h);
            break;
        case BLUR_MODE_STACK:
            stackBlur(pixels, r, cores, index, direction, (int) w, (int) h);
            break;
        case BLUR_MODE_GAUSSIAN:
            gaussianBlur(pixels, r, cores, index, direction, (int) w, (int) h);
            break;
    }

    NSData *result = [NSData dataWithBytes:pixels length:data.length];

    return result;
}

+ (NSData *)blurInSingleBlock:(NSData *)data mode:(BlurMode)mode radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h {
    [BlurFilter blur:data mode:mode radius:r width:w height:h cores:1 index:0 direction:DIRECTION_HORIZONTAL];
    [BlurFilter blur:data mode:mode radius:r width:w height:h cores:1 index:0 direction:DIRECTION_VERTICAL];
    return data;
}

@end
