//
// Created by HokoFly on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import "BlurEnum.h"
#import "RunnableTask.h"


@interface BlurSubTask : NSObject<RunnableTask>

@property(nonatomic, assign) BlurMode mode;
@property(nonatomic, assign) NSInteger radius;
@property(nonatomic, assign) NSInteger cores;
@property(nonatomic, assign) NSInteger index;
@property(nonatomic, assign) NSData *pixelData;
@property(nonatomic, assign) BlurDirection direction;
@property(nonatomic, assign) NSInteger width;
@property(nonatomic, assign) NSInteger height;


- (instancetype)initWithMode:(BlurMode)mode radius:(NSInteger)radius cores:(NSInteger)cores index:(NSInteger)index pixelData:(NSData *)pixelData width:(NSInteger)w height:(NSInteger)h direction:(BlurDirection)direction;

+ (instancetype)taskWithMode:(BlurMode)mode radius:(NSInteger)radius cores:(NSInteger)cores index:(NSInteger)index pixelData:(NSData *)pixelData width:(NSInteger)w height:(NSInteger)h direction:(BlurDirection)direction;


@end