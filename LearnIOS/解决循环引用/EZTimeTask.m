//
//  EZDateUpdateTask.m
//  LearnIOS
//
//  Created by Even on 2019/6/14.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZTimeTask.h"

@implementation EZTimeTask

- (instancetype)initWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        self.target = target;
        self.selector = selector;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(taskTimer:) userInfo:nil repeats:repeats];
    }
    return self;
}

- (void)taskTimer:(NSTimer *)timer {
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        typeof(self) sself = weakSelf;
        
        if(!sself) {
            return;
        }
        
        if (sself.target == nil) {
            return;
        }
        
        id target = sself.target;
        SEL selector = sself.selector;
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector withObject:[NSDate date]];   //此处的object可以传入执行某个操作获取的数据
        }
        
    });
}

- (void)shutdown {
    [self.timer invalidate];
    self.timer = nil;
}

@end
