//
// Created by HokoFly on 2018/12/5.
//

#import "BlurResult.h"


@implementation BlurResult {

}

- (instancetype)initWithCompletionHandler:(BlurCompletionHandler)completionHandler {
    self = [super init];
    if (self) {
        self.completionHandler = completionHandler;
    }

    return self;
}

@end