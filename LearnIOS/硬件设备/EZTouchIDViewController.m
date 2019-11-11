//
//  EZTouchIDViewController.m
//  LearnIOS
//
//  Created by Even on 2019/7/12.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZTouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface EZTouchIDViewController ()

@end

@implementation EZTouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkTouchID];
}

- (void)checkTouchID {
    LAContext *context = [LAContext new];
    context.localizedCancelTitle = @"按下touch";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"我现在要使用指纹识别" reply:^(BOOL success, NSError * _Nullable error) {
            
        }];
    }else {
        NSLog(@"不支持指纹识别");
        NSLog(@"指纹错误的原因：%@", error);
    }
}

@end
