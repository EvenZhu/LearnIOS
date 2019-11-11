//
//  main.m
//  LearnIOS
//
//  Created by Even on 2019/4/28.
//  Copyright © 2019 Even. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CJMethodLog/CJMethodLog.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [CJMethodLog forwardingClasses:@[@"EZViewController"] logOptions:CJLogDefault|CJLogMethodTimer logEnabled:YES];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
