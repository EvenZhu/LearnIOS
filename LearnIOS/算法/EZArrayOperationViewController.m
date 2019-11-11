//
//  EZArrayOperationViewController.m
//  LearnIOS
//
//  Created by Even on 2019/8/1.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZArrayOperationViewController.h"

@interface EZArrayOperationViewController ()

@end

@implementation EZArrayOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a[5] = {1,3,10,14,24};
    int b[7] = {6,8,12,40,46};
    int c[12];
    mergeList(a, 5, b, 7, c);
}

// 将有序数组a和b的值合并到一个数组result当中，且仍然保持有序
void mergeList(int a[], int aLen, int b[], int bLen, int result[]) {
    int p = 0; // 遍历数组a的指针
    int q = 0; // 遍历数组b的指针
    int i = 0; // 记录当前存储位置
    
    // 任一数组没有到达边界则进行遍历
    while (p < aLen && q < bLen) {
        // 如果a数组对应位置的值小于b数组对应位置的值
        if (a[p] <= b[q]) {
            // 存储a数组的值
            result[i] = a[p];
            // 移动a数组的遍历指针
            p++;
        }
        else{
            // 存储b数组的值
            result[i] = b[q];
            // 移动b数组的遍历指针
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余
    while (p < aLen) {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = a[p++];
        i++;
    }
    
    // 如果b数组有剩余
    while (q < bLen) {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = b[q++];
        i++;
    }
}

@end
