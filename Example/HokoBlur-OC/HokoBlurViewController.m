//
//  HokoBlurViewController.m
//  HokoBlur-OC
//
//  Created by HokoFly on 11/16/2018.
//  Copyright (c) 2018 HokoFly. All rights reserved.
//

#import "HokoBlurViewController.h"

@interface HokoBlurViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HokoBlurViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"sample1"];
    self.imageView = [self.imageView initWithImage: image];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
