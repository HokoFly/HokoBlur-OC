//
// Created by HokoFly on 2018/11/21.
//

#import "UIImage+PixelsData.h"


@implementation UIImage (PixelsData)


- (NSData *)toPixelsData {

    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    unsigned char *rawData = calloc(width * height * 4, sizeof(unsigned char));

    if (rawData == nil) {
        [NSException raise:@"CallocException" format:@"Failed to alloc mem for %@", self];
    }

    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;

    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

    CGColorSpaceRelease(colorSpace);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);

    CGContextRelease(context);

    NSData *pixelData = [NSData dataWithBytes:rawData length:width * height * 4];

    free(rawData);

    return pixelData;

}

+ (instancetype)fromPixelsData:(NSData *)data width:(NSUInteger)w height:(NSUInteger)h {
    NSUInteger bitsPerPixel = 32;
    NSUInteger bitsPerComponent = 8;
    NSUInteger bytesPerRow = 4 * w;

    unsigned char *pixels = (unsigned char *) data.bytes;
    CGDataProviderRef provider = CGDataProviderCreateWithData(nil, pixels, w * h * 4, nil);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imageRef = CGImageCreate(w, h, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, kCGBitmapByteOrder32Big | kCGImageAlphaLast, provider, nil, NO, kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}
@end