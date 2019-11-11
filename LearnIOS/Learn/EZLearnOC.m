//
//  EZLearnOC.m
//  LearnIOS
//
//  Created by Even on 2019/6/11.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZLearnOC.h"
#import <math.h>

@implementation EZLearnOC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self mathExample];
        [self numberFormat];
        [self joinString:@"crop" @"玉米",@"土豆",@"棉花",@"绿豆", nil];
        [self operationPredicate];
        [self copyObject];
    }
    return self;
}

- (void)mathExample {
    NSLog(@"sin(90) = %f", sin(90));
    NSLog(@"asinf(90) = %f", asinf(90));
}

/**
 数据的不同进制转换
 */
- (void)numberFormat {
    NSLog(@"以科学计数法显示%f = %g", 2454354.543, 2454354.543);
    NSLog(@"八进制%#o = 十进制%i", 024, 024);
}

/**
 实现可变参数的方法

 @param firstItem 第一个参数
 */
- (void)joinString:(NSString *)firstItem,... __attribute__((sentinel)) {
    NSMutableArray *argsArray = [[NSMutableArray alloc]init];
    if(firstItem) {
        [argsArray addObject:firstItem];
    }
    va_list params;             //定义一个指向个数可变的参数列表指针
    va_start(params,firstItem); //va_start  得到第一个可变参数地址
    NSString *arg;
    while((arg = va_arg(params, NSString *)))   //va_arg 指向下一个参数地址
    {
        if(arg)
        {
            [argsArray addObject:arg];
        }
    }
    va_end(params);             //置空
    
    NSLog(@"可变参数拼接字符串结果：\n%@",argsArray);
}

/**
 谓词的基本使用
 */
- (void)operationPredicate {
    NSArray *objects = [[NSArray alloc] initWithObjects:@{@"name":@"zhangsan", @"age":@23}, @{@"name":@"lisi", @"age":@13}, @{@"name":@"wangwu", @"age":@18}, nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name IN {'zhangsan','lisi'}"];
    NSArray *newArray = [objects filteredArrayUsingPredicate:predicate];
    NSLog(@"谓词筛选结果：\n%@", newArray);
}

/**
 对象的深浅copy
 */
- (void)copyObject {
    NSArray *strings = @[@"abc", @"ijk", @"xyz"];
    NSArray *dicts = @[@{@"a":@"bc"}, @{@"i":@"jk"}, @{@"x":@"yz"}];
    NSArray *stringsCopy = strings.copy;
    NSArray *dictsCopy = dicts.copy;
    NSArray *stringsMutableCopy = strings.mutableCopy;
    NSArray *dictsMutableCopy = dicts.mutableCopy;
    NSLog(@"strings(%p) = %@", &strings,strings);
    NSLog(@"strings.copy(%p) = %@", &stringsCopy, stringsCopy);
    NSLog(@"strings.mutableCopy(%p) = %@", &stringsMutableCopy, stringsMutableCopy);
    NSLog(@"dicts(%p) = %@", &dicts,dicts);
    NSLog(@"dicts.copy(%p) = %@", &dictsCopy, dictsCopy);
    NSLog(@"dicts.mutableCopy(%p) = %@", &dictsMutableCopy, dictsMutableCopy);
}

@end
