//
//  EZMVVMView.m
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZMVVMView.h"
#import "EZMVVMViewController.h"

@interface EZMVVMView()

@end

@implementation EZMVVMView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                     userInfo:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewController:(EZMVVMViewController *)viewController {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewContrller = viewController;
        [self setupUI:frame];
    }
    return self;
}

- (void)setupUI:(CGRect)frame {
    [self addSubview:self.tableView];
    [self addSubview:self.webView];
    
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:requset];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150, 94, 200, 30)];
    [button setTitle:@"viewModel处理事件" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [button addTarget:self.viewContrller.viewModel action:@selector(actionWithTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 124, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 100) style:UITableViewStylePlain];
        _tableView.delegate = self.viewContrller.viewModel;
        _tableView.dataSource = self.viewContrller.viewModel;
    }
    return _tableView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 200)];
        _webView.navigationDelegate = self.viewContrller.viewModel;
        _webView.UIDelegate = self.viewContrller.viewModel;
        
        _webView.backgroundColor = UIColor.lightGrayColor;
    }
    return _webView;
}

@end
