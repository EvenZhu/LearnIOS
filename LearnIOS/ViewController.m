//
//  ViewController.m
//  LearnIOS
//
//  Created by Even on 2019/4/28.
//  Copyright © 2019 Even. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "EZPhoto.h"
#import "EZRetainCycleVC.h"
#import "EZLocationVC.h"
#import "EZSqlLiteViewController.h"

#define NSLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:comment table:nil]

typedef void (^DemoBlock)(int,int);
static int static_global_val = 2;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_vcNames;
    DemoBlock demoBlock;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupView];
    
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply(10, queue, ^(size_t index) {
            NSLog(@"%zu", index);
        });
        NSLog(@"done");
    });
}

- (void)setupData {
    _vcNames = @[@{@"group":NSLocalizedString(@"save", nil),@"items":@[@[@"Sqlite",@"SQLite",@"Sqlite数据库"]]},
                 @{@"group":@"iOS框架",@"items":@[@[@"Dynamics",@"UIKit Dynamics",@"将物理模拟动作应用于UIView"],
                                                @[@"CoreLocation",@"CoreLocation",@""],
                                                @[@"AddressBook",@"通讯录",@"通讯录框架的使用"]]},
                 @{@"group":@"硬件设备",@"items":@[@[@"TouchID",@"TouchID",@""]]},
                 @{@"group":@"图片",@"items":@[@[@"GPUImage",@"GPU绘图",@""]]},
                 @{@"group":@"视图",@"items":@[@[@"",@"UIvieController"],
                                             @[@"TableView",@"列表"]]},
                 @{@"group":@"线程",@"items":@[@[@"Dispatch",@"Dispatch"]]},
                 @{@"group":@"算法",@"items":@[@[@"LinkedList",@"链表"],
                                             @[@"ArrayOperation",@"数组"],
                                             @[@"StringOperation",@"字符串"],
                                             @[@"ViewOperation",@"视图"],
                                             @[@"SortOperation",@"排序"],
                                             @[@"NumberOperation",@"数值"]]},
                 @{@"group":@"设计模式",@"items":@[@[@"MVVM",@"MVVM",@"MVVM设计模式"],]}];
    
    // 前台通过接口向后台请求数据
    // 将获取到的数据进行解析
    // 将解析后的数据进行格式化或序列化
    // 使用该数据进行适当的展现和运算
}

- (void)setupView {
    self.navigationItem.title = @"iOS开发训练";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _vcNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_vcNames[section][@"items"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _vcNames[section][@"group"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"homeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *vcItem = _vcNames[indexPath.section][@"items"][indexPath.row];
    if (vcItem) {
        NSString *vcTitle = vcItem[1];
        cell.textLabel.text = vcTitle.length>0?vcTitle:@"未定义";
        
        if (vcItem.count > 2) {
            NSString *vcDetail = vcItem[2];
            cell.detailTextLabel.text = vcDetail.length>0?vcDetail:@"暂无描述";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *vcItem = _vcNames[indexPath.section][@"items"][indexPath.row];
    if (vcItem) {
        NSString *vcName = vcItem[0];
        NSString *vcTitle = vcItem[1];
        if (vcTitle.length > 0) {
            UIViewController *vc = [NSClassFromString([NSString stringWithFormat:@"EZ%@ViewController", vcName]) new];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            NSLog(@"控制器<%@>初始化失败，无法跳转", vcTitle);
        }
    }
}

@end
