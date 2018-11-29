//
// Created by HokoFly on 2018/11/23.
//

#import <Foundation/Foundation.h>

@protocol BlurProcessor <NSObject>

@required

- (UIImage *) blur:(UIImage *)image;


@end