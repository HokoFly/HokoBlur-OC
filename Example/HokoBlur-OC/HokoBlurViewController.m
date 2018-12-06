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
#import <libextobjc/EXTScope.h>


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
        @weakify(self);
        dispatch_block_t cancellableTask = HokoBlur.mode(BLUR_MODE_STACK)
                .radius(20)
                .sampleFactor(5.0f)
                .processor()
                .asyncBlur(image, ^(BlurResult *result) {
                    @strongify(self)
                    if ([result success]) {
                        [self setImage:[result image] to:self.asyncImageView];
                    }
                });

        //test cancel
//        dispatch_block_cancel(cancellableTask);

        UIImage *blurred = HokoBlur.mode(BLUR_MODE_STACK)
                .radius(10)
                .sampleFactor(5.0f)
                .processor()
                .blur(image);
        [self setImage:blurred to:self.syncImageView];

    });


}


- (void)setImage:(UIImage *)image to:(UIImageView *)imageView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [imageView setImage:image];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
