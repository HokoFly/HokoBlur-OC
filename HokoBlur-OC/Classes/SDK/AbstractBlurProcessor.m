//
// Created by HokoFly on 2018/11/29.
//

#import "AbstractBlurProcessor.h"
#import "UIImage+PixelsData.h"


@implementation AbstractBlurProcessor {

}


- (UIImage *)blur:(UIImage *)image {
    CGFloat w = image.size.width * image.scale;
    CGFloat h = image.size.height * image.scale;
    CGFloat sampleFactor = 5.0;
    NSUInteger scaleW = (NSUInteger) (w / sampleFactor);
    NSUInteger scaleH = (NSUInteger) (h / sampleFactor);

    UIImage *scaleImage = [self resizeImage:image toSize:CGSizeMake(scaleW, scaleH)];

    NSData *data = [scaleImage toPixelsData];

    NSData *result = [self blurWithData:data width:scaleW height:scaleH];

    UIImage *blurredImage = [UIImage fromPixelsData:result width:scaleW height:scaleH];

    UIImage *upscaleImage = [self resizeImage:blurredImage toSize:CGSizeMake(scaleW, scaleH)];

    return upscaleImage;
}


- (UIImage *)resizeImage:(UIImage *)originImage toSize:(CGSize)scaledSize {

    UIGraphicsBeginImageContext(scaledSize);
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, scaledSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, scaledSize.width, scaledSize.height), originImage.CGImage);

    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return resizedImage;
}

- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h {
    return nil;
}


@end