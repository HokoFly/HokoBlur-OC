//
// Created by HokoFly on 2018/11/21.
//

#import <Foundation/Foundation.h>

@interface UIImage (PixelsData)

- (NSData *) toPixelsData;
+ (UIImage *)fromPixelsData:(NSData *)data width:(NSUInteger)w height:(NSUInteger)h;
@end
