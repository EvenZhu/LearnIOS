//
//  EZLocationVC.h
//  LearnIOS
//
//  Created by Even on 2019/6/16.
//  Copyright © 2019 Even. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZLocationVC : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;

@end

NS_ASSUME_NONNULL_END
