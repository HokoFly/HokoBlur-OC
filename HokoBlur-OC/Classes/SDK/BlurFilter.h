//
// Created by HokoFly on 2018/11/22.
//

#import <Foundation/Foundation.h>
#import "BlurMode.h"


@interface BlurFilter : NSObject

+ (NSData *)blur:(NSData *)pixels mode:(BlurMode)mode radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h;

@end
