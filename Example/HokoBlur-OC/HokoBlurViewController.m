//
//  HokoBlurViewController.m
//  HokoBlur-OC
//
//  Created by HokoFly on 11/16/2018.
//  Copyright (c) 2018 HokoFly. All rights reserved.
//

#import "HokoBlurViewController.h"
#import "DefaultBlurProcessor.h"
#import "HokoBlur.h"
#import "BlurResult.h"


@interface HokoBlurViewController ()
@property(strong, nonatomic) IBOutlet UIImageView *asyncImageView;
@property(strong, nonatomic) IBOutlet UIImageView *syncImageView;

@end

@implementation HokoBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_queue_t blurQueue = dispatch_queue_create("blur.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(blurQueue, ^{
        UIImage *image = [UIImage imageNamed:@"sample1"];
        [self setImage:image to:self.asyncImageView];
        HokoBlur.mode(BLUR_MODE_STACK)
                .radius(20)
                .sampleFactor(5.0f)
                .processor()
                .asyncBlur(image, ^(BlurResult *result) {
                    if ([result success]) {
                        [self setImage:[result image] to:self.asyncImageView];
                    }
                });

        UIImage *blurred = HokoBlur.mode(BLUR_MODE_STACK)
                .radius(10)
                .sampleFactor(5.0f)
                .processor()
                .blur(image);
        [self setImage:blurred to:self.syncImageView];

    });


}


- (void)setImage:(UIImage *)image to:(UIImageView *)imageView {
//    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if (strongSelf) {
        [imageView setImage:image];
//        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
