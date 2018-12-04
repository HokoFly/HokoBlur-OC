//
// Created by HokoFly on 2018/11/29.
//

#import "AbstractBlurProcessor.h"
#import "UIImage+PixelsData.h"


@implementation BlurProcessorBuilder {

}

- (instancetype)init {
    if (self = [super init]) {
        self.mode = BLUR_MODE_STACK;
        self.radius = 10;
        self.sampleFactor = 5.0;
        self.forceCopy = NO;
        self.needUpscale = YES;
    }

    return self;
}

@end

@implementation AbstractBlurProcessor {

}

- (UIImage *(^)(UIImage *))blur {
    return ^UIImage *(UIImage *image) {
        return [self blur:image inParallel:YES];
    };
}

- (UIImage *)blur:(UIImage *)image inParallel:(BOOL)parallel {
    [self checkParameters];

    CGFloat w = image.size.width * image.scale;
    CGFloat h = image.size.height * image.scale;
    CGFloat sampleFactor = [self sampleFactor];

    NSUInteger scaleW = (NSUInteger) (w / sampleFactor);
    NSUInteger scaleH = (NSUInteger) (h / sampleFactor);

    UIImage *inImage = image;
    if (self.forceCopy) {
        inImage = [UIImage imageWithCGImage:image.CGImage];
    }

    UIImage *scaleImage = [self resizeImage:inImage toSize:CGSizeMake(scaleW, scaleH)];

    NSData *data = [scaleImage toPixelsData];

    NSData *result = [self blurWithData:data width:scaleW height:scaleH inParallel:parallel];

    UIImage *blurredImage = [UIImage fromPixelsData:result width:scaleW height:scaleH];

    UIImage *outImage = blurredImage;
    if (self.needUpscale) {
        outImage = [self resizeImage:blurredImage toSize:CGSizeMake(scaleW, scaleH)];
    }

    return outImage;
}

- (void)checkParameters {
    if (self.radius < 0) {
        self.radius = 1;
    }

    if (self.sampleFactor < 1.0f) {
        self.sampleFactor = 1.0f;
    }
}

- (UIImage *)resizeImage:(UIImage *)originImage toSize:(CGSize)scaledSize {

    UIGraphicsBeginImageContext(scaledSize);
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, scaledSize.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, CGRectMake(0, 0, scaledSize.width, scaledSize.height), originImage.CGImage);

    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return resizedImage;
}

- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h inParallel:(BOOL)parallel {
    return data;
}

- (instancetype)init {
    BlurProcessorBuilder *builder = [[BlurProcessorBuilder alloc] init];
    return [self initWithBuilder:builder];
}




- (instancetype)initWithBuilder:(BlurProcessorBuilder *)builder {

    if (self = [super init]) {
        self.mode = builder.mode;
        self.radius = builder.radius;
        self.sampleFactor = builder.sampleFactor;
        self.forceCopy = builder.forceCopy;
        self.needUpscale = builder.needUpscale;
    }
    return self;
}

+ (instancetype)makeWithBuilder:(void (^)(BlurProcessorBuilder *))updateBlock {
    BlurProcessorBuilder *builder = [[BlurProcessorBuilder alloc] init];
    updateBlock(builder);
    return [[AbstractBlurProcessor alloc] initWithBuilder:builder];
}


- (instancetype)update:(void (^)(BlurProcessorBuilder *))updateBlock {
    BlurProcessorBuilder *builder = [self makeBuilder];
    updateBlock(builder);
    return [[AbstractBlurProcessor alloc] initWithBuilder:builder];
}

- (BlurProcessorBuilder *)makeBuilder {
    BlurProcessorBuilder *builder = [[BlurProcessorBuilder alloc] init];
    builder.mode = self.mode;
    builder.radius = self.radius;
    builder.sampleFactor = self.sampleFactor;
    builder.forceCopy = self.forceCopy;
    builder.needUpscale = self.needUpscale;
    return builder;
}


@end
