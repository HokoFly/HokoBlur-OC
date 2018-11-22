//
// Created by HokoFly on 2018/11/22.
//

#import <Foundation/Foundation.h>


@interface BlurFilter : NSObject

+ (NSData *)blur:(NSData *)pixels radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h;

@end
