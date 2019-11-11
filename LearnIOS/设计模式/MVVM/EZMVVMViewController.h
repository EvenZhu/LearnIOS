//
//  EZMVVMViewController.h
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZBaseViewController.h"
#import "EZMVVMView.h"
#import "EZMVVMViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EZMVVMViewController : EZBaseViewController

@property (nonatomic, strong) EZMVVMView *mView;
@property (nonatomic, strong) EZMVVMViewModel *viewModel;

-(void)setupUI;
-(void)setupData;
-(void)setupViemModel;

@end

NS_ASSUME_NONNULL_END
