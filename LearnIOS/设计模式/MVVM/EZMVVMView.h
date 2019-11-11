//
//  EZMVVMView.h
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EZMVVMViewController;

@interface EZMVVMView : UIView

@property (nonatomic, weak) EZMVVMViewController *viewContrller;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WKWebView *webView;

- (void)setupUI;

- (instancetype)initWithFrame:(CGRect)frame viewController:(EZMVVMViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
