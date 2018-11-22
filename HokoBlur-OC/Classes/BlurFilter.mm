//
// Created by HokoFly on 2018/11/22.
//

#import "BlurFilter.h"
#import "StackBlurFilter.h"


@implementation BlurFilter {

}

+ (NSData *)blur:(NSData *)data radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h {
    uint32_t *pixels = (uint32_t *) [data bytes];

    stackBlur((int *) pixels, r, 1, 0, hokoblur::HORIZONTAL, (int) w, (int) h);
    stackBlur((int *) pixels, r, 1, 0, hokoblur::VERTICAL, (int) w, (int) h);

    NSData *result = [NSData dataWithBytes:pixels length:data.length];

    return result;
}

@end
