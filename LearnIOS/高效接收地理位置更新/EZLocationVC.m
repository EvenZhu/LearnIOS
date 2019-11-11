//
//  EZLocationVC.m
//  LearnIOS
//
//  Created by Even on 2019/6/16.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZLocationVC.h"

@interface EZLocationVC ()

@end

@implementation EZLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    
    [self setupView];
}

- (void)setupView {
    UIButton *startButton = [UIButton new];
    [startButton setTitle:@"启动定位" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(enableLocationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    startButton.sd_layout
    .widthIs(90)
    .heightIs(30)
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view);
}

- (void)enableLocationAction:(UIButton *)sender {
    self.manager.distanceFilter = kCLDistanceFilterNone;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    NSString *version = UIDevice.currentDevice.systemVersion;
    NSInteger versionNumber = [[version substringToIndex:[version rangeOfString:@"." options:nil].location] integerValue];
    if (versionNumber > 8) {
        [self.manager requestWhenInUseAuthorization];
    }
    
    [self.manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations lastObject];
    //使用定位信息
}

@end
