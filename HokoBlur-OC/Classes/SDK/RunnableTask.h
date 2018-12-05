//
// Created by HokoFly on 2018/12/5.
//

#import <Foundation/Foundation.h>

@protocol RunnableTask <NSObject>

@required
- (void)run;
@end