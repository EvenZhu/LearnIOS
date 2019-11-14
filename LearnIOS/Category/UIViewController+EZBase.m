//
//  UIViewController+EZBase.m
//  LearnIOS
//
//  Created by Even on 2019/11/11.
//  Copyright © 2019 Even. All rights reserved.
//

#import "UIViewController+EZBase.h"
#import <objc/runtime.h>

@implementation UIViewController (EZBase)

+ (void)load {

    SEL oldSel = @selector(viewDidLoad);
    SEL newSel = @selector(ez_viewDidLoad);
    Method oldMethod = class_getInstanceMethod(self, oldSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(oldMethod, newMethod);
}

- (void)ez_viewDidLoad {
    if ([self isMemberOfClass:[UIViewController class]]) {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    [self ez_viewDidLoad];
}

@end
