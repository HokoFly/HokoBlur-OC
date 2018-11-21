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

@end