//
// Created by HokoFly on 2018/12/5.
//

#import <Foundation/Foundation.h>
#import "BlurProcessor.h"


@interface BlurResult : NSObject

@property(nonatomic, assign) BOOL success;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) BlurCompletionHandler completionHandler;
@property(nonatomic, strong) NSError *error;

- (instancetype)initWithCompletionHandler:(BlurCompletionHandler)completionHandler;

@end