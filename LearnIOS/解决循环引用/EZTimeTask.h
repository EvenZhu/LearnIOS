//
//  EZDateUpdateTask.h
//  LearnIOS
//
//  Created by Even on 2019/6/14.
//  Copyright © 2019 Even. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZTimeTask : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong, nullable) NSTimer *timer;

- (instancetype)initWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats target:(id)target selector:(SEL)selector;
- (void)shutdown;

@end

NS_ASSUME_NONNULL_END
