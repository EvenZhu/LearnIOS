//
//  EZGrammerViewController.m
//  LearnIOS
//
//  Created by Even on 2019/11/11.
//  Copyright © 2019 Even. All rights reserved.
//

//#include "EZGrammerViewController.h" // 使用include会引起头文件的多次引用
#import "EZGrammerViewController.h" // 可以避免文件被多次引用
#import "LearnIOS-Swift.h"

// 实现一个代理协议，需要在类实现中实现该代理的方法
@interface EZGrammerViewController () <UIGestureRecognizerDelegate> {
    NSString *_mString;
}

/** property可以快速方便的为实例变量创建存取器，并允许我们通过点语法使用存取
    修饰符的关键词包含三种：
    原子性：atomic和nonatomic
    存储器控制：readwrite和readonly
    内存管理方式：assign、strong、weakl、copy
 */
@property (nonatomic, assign) int propertyCount;
@property (nonatomic, copy) NSString *propertyDesc;

- (void)interfaceMethod;

@end

@implementation EZGrammerViewController

@synthesize propertyCount = __count;  //@synthesize表示如果属性没有手动实现setter和getter方法，编译器会自动加上这两个方法。
@dynamic propertyDesc;  //@dynamic 告诉编译器：属性的 setter 与 getter 方法由用户自己实现，不自动生成

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.propertyDesc = @"@property的作用是申明属性及其特性";
    self.propertyCount = 10;    // 由于@synthesize的作用，_propertyCount无法访问，__count可以访问
    
    EZLearnSwift *learnSwift = [EZLearnSwift new];
    
    // NSSet可以存储不同类型的对象，可以添加和删除
    // NSSet和我们常用NSArry区别是：在搜索一个一个元素时NSSet比NSArray效率高，主要是它用到了一个算法hash
    NSSet *set = [NSSet setWithObjects:@"abc", @"gfe", @3, nil];
    set = [set setByAddingObject:@"123"];
    NSLog(@"abc in NSSet is <%zu>", [set indexOfAccessibilityElement:@"abc"]);
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"obj = (%@), class = %@", obj, [obj class]);
    }];
    
    NSMutableDictionary *names = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"张三", @"左护法", @"李四", @"右使", @"唐sir", @"老大哥", nil];
    [names removeObjectForKey:@"左护法"];  // dictionary只能根据键、键的数组删除某个对象或者删除全部对象
    
//    [names removeObjectForKey:nil]; // key永远不能为nil
//    [names setObject:nil forKey:@"123"]; // 不能添加nil对象
    
    NSURL *url = [NSURL URLWithString:nil];  // url初始化不能传入nil，但是没有崩溃
   
    NSString *strA = [NSString stringWithFormat:@"a"];
    NSString *strB = [NSString stringWithFormat:@"a"];
//    NSLog(@"%d", [name reatinCount]);   // 在MRC模式下输出-1
    NSLog(@"%d, %d", strA == strB, [strA isEqualToString:strB]);
    
    [self aMethod:@"test" :12 andNumer:0];
    
    /** 下面是NSObject的部分内省方法，也可以称为检查方法
        1、isKindOfClass:Class               // 检查对象是否是那个类或者其继承类实例化的对象
        2、isMemberOfClass:Class         // 检查对象是否是那个类但不包括继承类实例化的对象
        if ([item isKindClass:[NSData class]]) {
           // ...
        }
        3、respondToSelector:selector    // 检查对象是否包含这个方法
        4、conformsToProtocol:protocol  //检查对象是否符合协议，是否实现了协议中所有的必选方法
     */
    
    NSLog(@"是否符合协议（是否实现了所有必选方法）：%d", [self conformsToProtocol:@protocol(UIGestureRecognizerDelegate)]);    // 此处打印1，因为该协议的方法都是optional

    NSString *dataStr = [[NSData alloc] init];
    NSLog(@"dataStr = %@, class = %@", dataStr, [dataStr class]);
    
    NSString *str = nil;
    NSString *str1 = [str substringFromIndex:3];
    
    NSString *str2 = @"hi";
    NSString *str3 = [str substringToIndex:-1];
    
}

/// 测试方法的参数名称
/// @param emthodName 方法名称
/// @param count 数量
/// @param number 数
- (void)aMethod:(NSString *)emthodName :(NSInteger)count andNumer:(NSInteger)number {
}

- (void)testMethod:(NSString *)methodName {
}
/// 该方法同上个方法的名称和参数个数一致，所以表现在类的方法列表中的方法名一致，会导致编译失败
/// @param argumentsCount 参数列表
//- (void)testMethod:(NSInteger *)argumentsCount {
//}

- (void)dealloc {
    /**
     1. 为 C++ 的实例变量们（iVars）调用 destructors
     2. 为 ARC 状态下的 实例变量们（iVars） 调用 -release
     3. 解除所有使用 runtime Associate方法关联的对象
     4. 解除所有 __weak 引用
     5. 调用 free()
     */
    
}

@end
