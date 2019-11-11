//
//  EZViewController.m
//  LearnIOS
//
//  Created by Even on 2019/9/11.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZViewController.h"
#import <objc/runtime.h>

@interface EZViewController ()

@end

@implementation EZViewController

/**
 一般不需要u实现此方法
 除非页面控制器上只显示一个图片或者根视图是一个WebView
 */
//- (void)loadView {
//    self.view = [UIView new];
//}

/**
 视同控制器控制的主视图加载完成之后执行该方法（Storyboard或者Xib文件中加载、或者LoadView中设置self.view）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 如果未从Storyboard或者Xib文件加载view，则会创建一个空白的view赋值给self.view
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"使用了CJMethodLog对该类的所有方法进行追踪！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 当页面的自视图变更时会执行该方法（可能多次执行）
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

/**
 self.view即将展现在屏幕上时调用
 
 @param animated 是否展现动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/**
 self.view完全展现在屏幕上时调用
 
 @param animated 是否展现动画效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


/**
 页面即将从当前window移除时调用
 
 @param animated 是否展现动画效果
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

/**
 页面已经从当前window移除时调用

 @param animated 是否展现动画效果
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/**
 接收到内存警告之后触发该方法
 */
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
