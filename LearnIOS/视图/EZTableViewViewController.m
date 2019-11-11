//
//  EZTableViewViewController.m
//  LearnIOS
//
//  Created by Even on 2019/7/15.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZTableViewViewController.h"

@interface EZTableViewViewController () <UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate> {
    UITableView *_tableView;
    UIRefreshControl *_refreshControl;
    NSMutableArray *_nums;
}

@end

@implementation EZTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupView];
}

- (void)setupData {
    _nums = [NSMutableArray new];
    [self generateRandomNums];
}

- (void)setupView {
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:NSSelectorFromString(@"changeEditState:")];
    self.navigationItem.rightBarButtonItem = edit;
    
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:NSSelectorFromString(@"refreshControlAction:") forControlEvents:UIControlEventValueChanged];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_tableView addSubview:_refreshControl];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.dragDelegate = self;
    _tableView.dropDelegate = self;
    [self.view addSubview:_tableView];
}

- (void)changeEditState:(UIBarButtonItem *)editBarButtonItem {
    if ([editBarButtonItem.title isEqualToString:@"编辑"]) {
        editBarButtonItem.title = @"完成";
        [_tableView setEditing:YES];
    }else {
        editBarButtonItem.title = @"编辑";
        [_tableView setEditing:NO];
    }
}

- (void)refreshControlAction:(UIRefreshControl *)refreshControl {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self generateRandomNums];
        [_refreshControl endRefreshing];
        [_tableView reloadData];
    });
}

- (void)generateRandomNums {
    [_nums removeAllObjects];
    for (int i = 0; i < 10; i++) {
        [_nums addObject:[NSNumber numberWithInt:arc4random_uniform(10)]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"数字：%zu", _nums[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSNumber *moveNumber = _nums[sourceIndexPath.row];
    [_nums removeObjectAtIndex:sourceIndexPath.row];
    [_nums insertObject:moveNumber atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            [_nums removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

@end
