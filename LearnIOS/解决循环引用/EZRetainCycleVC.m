//
//  EZRetainCycleVC.m
//  LearnIOS
//
//  Created by Even on 2019/6/14.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZRetainCycleVC.h"
#import "EZTimeTask.h"

@interface EZRetainCycleVC ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) EZTimeTask *updateTask;

@end

@implementation EZRetainCycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    self.updateTask = [[EZTimeTask alloc] initWithTimeInterval:1 repeats:YES target:self selector:@selector(updateDate:)];
    
    [self addObserver:self forKeyPath:@"dateLabel.text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"dateLabel.text"]) {
//        DDLogInfo(@"objct = %@,changed = %@", object, change);
    }
}

- (void)setupView {
    
    self.dateLabel = [UILabel new];
    [self.view addSubview:self.dateLabel];
    self.dateLabel.text = [self stringByDate:[NSDate date]];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    
    self.dateLabel.sd_layout
    .widthIs(self.view.height)
    .heightEqualToWidth()
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    cancelButton.sd_layout
    .widthIs(90)
    .heightIs(30)
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(self.view, 44);
}

- (void)updateDate:(NSDate *)date {
    self.dateLabel.text = [self stringByDate:date];
}

- (NSString *)stringByDate:(NSDate *)date {
    return [date.description substringToIndex:20];
}

- (void)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [self.updateTask shutdown];
}

@end
