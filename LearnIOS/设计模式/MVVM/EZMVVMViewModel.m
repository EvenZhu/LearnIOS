//
//  EZMVVMViewModel.m
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZMVVMViewModel.h"
#import "EZMVVMViewController.h"
#import "EZMVVMModel.h"

@implementation EZMVVMViewModel

- (instancetype)initWithViewController:(EZMVVMViewController *)viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)requestWithURL:(sucessBlock)sucessBlock {
    NSMutableArray *modelsTemp = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 7; i++) {
        NSArray *names = @[@"张三",@"李四",@"王五",@"赵六",@"田七",@"洪八",@"朱九"];
        
        EZMVVMModel *model = [[EZMVVMModel alloc] init];
        NSMutableArray *itemsTemp = [[NSMutableArray alloc] init];
        for (int j = 0; j < i; j++) {
            [itemsTemp addObject:@(j)];
        }
        model.items = itemsTemp;
        model.index = [NSNumber numberWithInt:i];
        model.title = names[i];
        model.desc = [NSString stringWithFormat:@"这是第%d条数据，姓名为：%@", i, names[i]];
        
        [modelsTemp addObject:model];
    }
    
    self.models = modelsTemp.copy;
    sucessBlock(YES);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"表格列表项个数为：%zu", self.models.count);
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (self.models.count > indexPath.row && self.models[indexPath.row]) {
        EZMVVMModel *model = self.models[indexPath.row];
        cell.textLabel.text = model.title;
        cell.detailTextLabel.text = model.desc;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.models.count > indexPath.row && self.models[indexPath.row]) {
        EZMVVMModel *model = self.models[indexPath.row];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"用户信息条目" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        if (model.items.count) {
            for (NSNumber *number in model.items) {
                [alert addAction:[UIAlertAction actionWithTitle:number.description style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"您选取了%d", number.intValue);
                }]];
            }
        }else {
            [alert addAction:[UIAlertAction actionWithTitle:@"用户信息条目为空" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"信息记录为空");
            }]];
        }
        
        [self.viewController presentViewController:alert animated:YES completion:nil];
    }
}

- (void)actionWithTarget:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"这是一个ViewModel处理的事件" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

@end
