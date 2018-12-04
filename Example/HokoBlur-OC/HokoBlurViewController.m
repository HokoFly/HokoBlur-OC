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
        UIImage *blurred = HokoBlur.mode(BLUR_MODE_STACK)
                .radius(10)
                .sampleFactor(5.0f)
                .processor()
                .blur(image);
        [self setImage:blurred];

    });


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
