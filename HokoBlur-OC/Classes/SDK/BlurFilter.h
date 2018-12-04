//
// Created by HokoFly on 2018/11/22.
//

#import <Foundation/Foundation.h>
#import "BlurEnum.h"


@interface BlurFilter : NSObject

+ (NSData *)blur:(NSData *)data mode:(BlurMode)mode radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h cores:(NSInteger)cores index:(NSInteger)index direction:(BlurDirection)direction;
+ (NSData *)blurInSingleBlock:(NSData *)data mode:(BlurMode)mode radius:(NSInteger)r width:(NSInteger)w height:(NSInteger)h;

@end
