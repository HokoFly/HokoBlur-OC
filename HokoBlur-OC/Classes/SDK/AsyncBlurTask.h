//
// Created by HokoFLy on 2018/12/5.
//

#import <Foundation/Foundation.h>
#import "RunnableTask.h"
#import "BlurProcessor.h"

@protocol BlurProcessor;
@protocol BlurResultDispatcher;
@class BlurResult;
//
//@protocol AsyncBlurTaskDelegate <NSObject>
//
//-(void)onSuccess:(UIImage *)image;
//-(void)onFailed:(NSError *)error;
//
//@end

@interface AsyncBlurTask : NSObject <RunnableTask>
@property(nonatomic, copy) BlurCompletionHandler completionHandler;
@property(nonatomic, strong) id <BlurProcessor> processor;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) id <BlurResultDispatcher> resultDispacher;

- (instancetype)initWithDelegate:(BlurCompletionHandler)completionHandler processor:(id <BlurProcessor>)processor image:(UIImage *)image;

+ (instancetype)taskWithDelegate:(BlurCompletionHandler)completionHandler processor:(id <BlurProcessor>)processor image:(UIImage *)image;

@end