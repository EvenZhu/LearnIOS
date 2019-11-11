//
//  EZPhoto.h
//  LearnIOS
//
//  Created by Even on 2019/6/14.
//  Copyright © 2019 Even. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZPhoto : NSObject

//@property (nonatomic, strong) EZAlbum *album;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *comments;

@end

NS_ASSUME_NONNULL_END
