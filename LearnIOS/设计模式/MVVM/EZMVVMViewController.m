//
//  EZMVVMViewController.m
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZMVVMViewController.h"

@interface EZMVVMViewController ()

@end

@implementation EZMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViemModel];
    [self setupUI];
    [self setupData];
}

- (void)setupViemModel {
    self.viewModel = [[EZMVVMViewModel alloc] initWithViewController:self];
    self.mView = [[EZMVVMView alloc] initWithFrame:self.view.bounds viewController:self];
}

- (void)setupData {
    [self.viewModel requestWithURL:^(BOOL isSucess) {
        [self.mView.tableView reloadData];
    }];
}

- (void)setupUI {
    [self.view addSubview:self.mView];
}

@end
