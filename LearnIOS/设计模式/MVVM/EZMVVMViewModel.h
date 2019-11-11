//
//  EZMVVMViewModel.h
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^sucessBlock)(BOOL isSucess);

@class EZMVVMViewController;
@class EZMVVMModel;

@interface EZMVVMViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, weak) EZMVVMViewController *viewController;
@property (nonatomic, strong) NSArray<EZMVVMModel*> *models;

- (instancetype)initWithViewController:(EZMVVMViewController *)viewController;

- (void)requestWithURL:(sucessBlock __nullable)sucessBlock;
- (void)actionWithTarget:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
