//
//  EZMVVMModel.h
//  LearnIOS
//
//  Created by Even on 2019/10/17.
//  Copyright © 2019 Even. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZMVVMModel : NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSNumber *index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

@end

@interface EZMVVMItemModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;

@end

NS_ASSUME_NONNULL_END
