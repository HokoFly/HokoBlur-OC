//
// Created by HokoFly on 2018/12/4.
//

#import "BlurSubTask.h"
#import "BlurFilter.h"


@implementation BlurSubTask {

}

- (instancetype)initWithMode:(BlurMode)mode radius:(NSInteger)radius cores:(NSInteger)cores index:(NSInteger)index pixelData:(NSData *)pixelData width:(NSInteger)w height:(NSInteger)h direction:(BlurDirection) direction {
    self = [super init];
    if (self) {
        self.mode = mode;
        self.radius = radius;
        self.cores = cores;
        self.index = index;
        self.pixelData = pixelData;
        self.direction = direction;
        self.width = w;
        self.height = h;
    }

    return self;
}

+ (instancetype)taskWithMode:(BlurMode)mode radius:(NSInteger)radius cores:(NSInteger)cores index:(NSInteger)index pixelData:(NSData *)pixelData  width:(NSInteger)w height:(NSInteger)h direction:(BlurDirection)direction {
    return [[self alloc] initWithMode:mode radius:radius cores:cores index:index pixelData:pixelData width:w height:h direction:direction];
}

- (void (^)(void))run {
    return ^{
        [self applyPixelsBlur];
    };
}

- (void)applyPixelsBlur {

    [BlurFilter blur:self.pixelData mode:self.mode radius:self.radius width:self.width height:self.height cores:self.cores index:self.index direction:self.direction];

}


@end
