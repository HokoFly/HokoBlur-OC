//
// Created by HokoFly on 2018/11/29.
//




#import "DefaultBlurProcessor.h"
#import "BlurFilter.h"

@implementation DefaultBlurProcessor {

}
- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h {

    NSData *result = [BlurFilter blur:data mode:self.mode radius:self.radius width:w height:h];
    return result;
}


@end