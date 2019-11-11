//
//  EZDispatchViewController.m
//  LearnIOS
//
//  Created by Even on 2019/7/16.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZDispatchViewController.h"

@interface EZDispatchViewController ()

@end

@implementation EZDispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     主队列：专门负责调度主线程度的任务，没有办法开辟新的线程。所以，
     在主队列下的任务不管是异步任务还是同步任务都不会开辟线程，任务只会在主线程顺序执行
     **/
    
    /**
     主队列永远不用添加串行任务操作！！！
     因为目前所在的主队列方法会等待串行任务完成之后继续执行，
     而主队列中添加的任务必须等待主队列其他任务完成之后才能执行，
     于是就会形成相互等待，造成死锁
 
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"主队列同步：%@",[NSThread currentThread]);
    });
    **/
    
    /**
     主队列异步任务
     **/
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"主队列异步   %@",[NSThread currentThread]);
    });
    
    /**
     串行队列同步任务
     **/
    dispatch_queue_t queue =dispatch_queue_create("serial",DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"queue1------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"queue2------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"queue3------%@", [NSThread currentThread]);
        }
    });
    
    /**
     串行队列异步任务
     **/
    dispatch_queue_t serialQueue =dispatch_queue_create("serial",DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"serialQueue1------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"serialQueue2------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"serialQueue3------%@", [NSThread currentThread]);
        }
    });
    
    /**
     并行队列同步任务
     **/
    dispatch_queue_t concurrentQueue =dispatch_queue_create("concurrent",DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"concurrentQueue1------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"concurrentQueue2------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"concurrentQueue3------%@", [NSThread currentThread]);
        }
    });
    
    /**
     并行队列异步任务
     **/
    dispatch_queue_t concurrentQueue1 =dispatch_queue_create("concurrent",DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue1, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"concurrentQueue1-1------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue1, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"concurrentQueue1-2------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue1, ^{
        for (int i =0; i <3; i ++) {
            NSLog(@"concurrentQueue1-3------%@", [NSThread currentThread]);
        }
    });
}

@end
