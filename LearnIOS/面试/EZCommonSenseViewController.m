//
//  EZCommonSenseViewController.m
//  LearnIOS
//
//  Created by Even on 2019/11/13.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZCommonSenseViewController.h"
#import <objc/runtime.h>

@interface EZCommonSenseViewController ()

@end

@implementation EZCommonSenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hasSuperClass:[self class]];
}


/// 获取父类名称并打印
/// @param class 当前类型
- (void)hasSuperClass:(Class)class {
    Class superClass = class_getSuperclass(class);
    if (superClass != nil) {
        NSLog(@"-superClass:%@", superClass);
        [self hasSuperClass:superClass];
    }
}

@end
