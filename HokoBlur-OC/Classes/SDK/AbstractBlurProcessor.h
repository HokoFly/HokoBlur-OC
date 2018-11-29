//
// Created by HokoFly on 2018/11/29.
//

#import <Foundation/Foundation.h>
#import "BlurProcessor.h"


@interface AbstractBlurProcessor : NSObject <BlurProcessor>

- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h;
@end