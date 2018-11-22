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
        NSData *data = [image toPixelsData];

        CGFloat w = image.size.width * image.scale;
        CGFloat h = image.size.height * image.scale;

        NSData *result = [BlurFilter blur:data radius:20 width:(NSInteger) w height:(NSInteger) h];
        UIImage *blurredImage = [UIImage fromPixelsData:result width:(NSUInteger) w height:(NSUInteger) h];

        [self setImage:blurredImage];

    });


}

- (void)setImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self imageView] setImage:image];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
