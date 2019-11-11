//
//  EZViewOperationViewController.m
//  LearnIOS
//
//  Created by Even on 2019/8/1.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZViewOperationViewController.h"

@interface EZViewOperationViewController ()

@end

@implementation EZViewOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = UIColor.redColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    label.text = @"文字标签";
    
    [view addSubview:label];
    
    [self.view addSubview:view];
    NSLog(@"共同的父级View为：%@", [self findCommonSuperView:view other:label]);
}

- (NSArray <UIView *> *)findCommonSuperView:(UIView *)viewOne other:(UIView *)viewOther
{
    NSMutableArray *result = [NSMutableArray array];
    
    // 查找第一个视图的所有父视图
    NSArray *arrayOne = [self findSuperViews:viewOne];
    // 查找第二个视图的所有父视图
    NSArray *arrayOther = [self findSuperViews:viewOther];
    
    int i = 0;
    //开始查找---> 倒序遍历,因为他们的最顶端的父视图肯定都是UIWindow
    while (i < MIN((int)arrayOne.count, (int)arrayOther.count)) {
        // 倒序方式获取各个视图的父视图
        UIView *superOne = [arrayOne objectAtIndex:arrayOne.count - i - 1];
        UIView *superOther = [arrayOther objectAtIndex:arrayOther.count - i - 1];
        
        // 比较如果相等 则为共同父视图
        if (superOne == superOther) {
            [result addObject:superOne];
            i++;
        }
        //  不相等说明已经没有共同的父视图了
        else{
            break;
        }
    }
    
    return result;
}

- (NSArray <UIView *> *)findSuperViews:(UIView *)view
{
    // 初始化为第一父视图
    UIView *temp = view.superview;
    // 保存结果的数组
    NSMutableArray *result = [NSMutableArray array];
    while (temp) {
        [result addObject:temp];
        // 顺着superview指针一直向上查找
        temp = temp.superview;
    }
    return result;
}


@end
