//
// Created by HokoFly on 2018/11/29.
//




#import "DefaultBlurProcessor.h"
#import "BlurFilter.h"
#import "BlurTaskManager.h"
#import "BlurSubTask.h"

@implementation DefaultBlurProcessor {

}
- (NSData *)blurWithData:(NSData *)data width:(NSInteger)w height:(NSInteger)h inParallel:(BOOL)parallel{
    NSData *result = nil;

    if (parallel) {
        NSUInteger cores = [BlurTaskManager instance].workersNum;
        NSMutableArray<BlurSubTask *> *hTasks = [NSMutableArray arrayWithCapacity:cores];
        NSMutableArray<BlurSubTask *> *vTasks = [NSMutableArray arrayWithCapacity:cores];
        for (NSInteger i = 0; i < cores; i++) {
            [hTasks addObject:[BlurSubTask taskWithMode:self.mode radius:self.radius cores:cores index:i pixelData:data width:w height:h direction:DIRECTION_HORIZONTAL]];
            [vTasks addObject:[BlurSubTask taskWithMode:self.mode radius:self.radius cores:cores index:i pixelData:data width:w height:h direction:DIRECTION_VERTICAL]];
        }

        [[BlurTaskManager instance] invokeAll:hTasks];
        [[BlurTaskManager instance] invokeAll:vTasks];
        result = data;

    } else {
        result = [BlurFilter blurInSingleBlock:data mode:self.mode radius:self.radius width:w height:h];
    }


    return result;
}


@end