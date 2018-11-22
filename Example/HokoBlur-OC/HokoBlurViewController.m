//
//  HokoBlurViewController.m
//  HokoBlur-OC
//
//  Created by HokoFly on 11/16/2018.
//  Copyright (c) 2018 HokoFly. All rights reserved.
//

#import "HokoBlurViewController.h"
#import "UIImage+PixelsData.h"
#import "BlurFilter.h"

@interface HokoBlurViewController ()
@property(strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HokoBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_queue_t blurQueue = dispatch_queue_create("blur.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(blurQueue, ^{
        UIImage *image = [UIImage imageNamed:@"sample1"];
        [self setImage:image];

        CGFloat w = image.size.width * image.scale;
        CGFloat h = image.size.height * image.scale;
        CGFloat sampleFactor = 5.0;
        NSUInteger scaleW = (NSUInteger) (w / sampleFactor);
        NSUInteger scaleH = (NSUInteger) (h / sampleFactor);

        UIImage *scaleImage = [self resizeImage:image toSize:CGSizeMake(scaleW, scaleH)];

        NSData *data = [scaleImage toPixelsData];

        NSData *result = [BlurFilter blur:data radius:10 width:scaleW height:scaleH];
        UIImage *blurredImage = [UIImage fromPixelsData:result width:scaleW height:scaleH];

        UIImage *upscaleImage = [self resizeImage:blurredImage toSize:CGSizeMake(scaleW, scaleH)];

        [self setImage:upscaleImage];

    });


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


- (void)setImage:(UIImage *)image {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [[strongSelf imageView] setImage:image];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
