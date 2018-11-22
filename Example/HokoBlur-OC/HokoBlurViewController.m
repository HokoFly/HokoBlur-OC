//
//  HokoBlurViewController.m
//  HokoBlur-OC
//
//  Created by HokoFly on 11/16/2018.
//  Copyright (c) 2018 HokoFly. All rights reserved.
//

#import "HokoBlurViewController.h"
#import "UIImage+PixelsData.h"

@interface HokoBlurViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HokoBlurViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    dispatch_queue_t blurQueue = dispatch_queue_create("blur.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(blurQueue, ^{
        UIImage *image = [UIImage imageNamed:@"sample1"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView = [self.imageView initWithImage: image];
        });
        NSData *data = [image toPixelsData];
        NSLog(@"result: %@", data);


    });



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end