//
//  ViewController.m
//  信号量
//
//  Created by Ben Lv on 2018/9/3.
//  Copyright © 2018年 avatar. All rights reserved.
//

#import "ViewController.h"
#import "ATBaseRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self text];
//    [self text2];
    [self text3];
   
}


- (void)text {
    //    /创建信号量为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/journalismApi" param:nil success:^(id data) {
//            信号量📶+1
            dispatch_semaphore_signal(semaphore);
            NSLog(@"1请求成功");
        } failure:^(NSInteger resultId, NSString *errorMsg) {
//            信号量📶+1
            dispatch_semaphore_signal(semaphore);
        }];
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/satinApi?type=1&page=1" param:nil success:^(id data) {
            //            信号量📶+1
            dispatch_semaphore_signal(semaphore);
            NSLog(@"2请求成功");
            
        } failure:^(NSInteger resultId, NSString *errorMsg) {
            //            信号量📶+1
            dispatch_semaphore_signal(semaphore);
        }];
        
    });
    
    dispatch_group_notify(group, queue, ^{
//        信号量 -1 为0时wait会阻塞线程
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"信号量为0");
        
        [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/satinCommentApi?id=27610708&page=1" param:nil success:^(id data) {
            
            NSLog(@"3请求成功");
            
        } failure:^(NSInteger resultId, NSString *errorMsg) {
            
        }];
    });
    
}

//主线程阻塞
- (void)text2 {
    NSLog(@"current1:%@",[NSThread currentThread]);
    
    dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
    [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/satinApi?type=1&page=1" param:nil success:^(id data) {
        dispatch_semaphore_signal(semaphore);
        NSLog(@"2请求成功");
        
    } failure:^(NSInteger resultId, NSString *errorMsg) {
        dispatch_semaphore_signal(semaphore);
    }];
    NSLog(@"你会来这儿吗1");
    NSLog(@"current1:%@",[NSThread currentThread]);
    //    #######阻塞了主线程
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //等待信号,当信号总量少于0 的时候就会一直等待 ,否则就可以正常的执行,并让信号总量-1
    
    NSLog(@"你会来这儿吗2");
    [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/satinCommentApi?id=27610708&page=1" param:nil success:^(id data) {
        
        NSLog(@"3请求成功");
        
    } failure:^(NSInteger resultId, NSString *errorMsg) {
        
    }];
    
    
}

- (void)text3 {
    dispatch_queue_t queue = dispatch_queue_create("ben", NULL);
    dispatch_async(queue, ^{
         NSLog(@"current1:%@",[NSThread currentThread]);
        dispatch_semaphore_t  semaphore = dispatch_semaphore_create(0);
        [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/journalismApi" param:nil success:^(id data) {
            dispatch_semaphore_signal(semaphore);
            NSLog(@"1请求成功");
        } failure:^(NSInteger resultId, NSString *errorMsg) {
            dispatch_semaphore_signal(semaphore);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //等待信号,当信号总量少于0 的时候就会一直等待 ,否则就可以正常的执行,并让信号总量-1
        
        [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/satinApi?type=1&page=1" param:nil success:^(id data) {
            dispatch_semaphore_signal(semaphore);
            NSLog(@"2请求成功");
            
        } failure:^(NSInteger resultId, NSString *errorMsg) {
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //等待信号,当信号总量少于0 的时候就会一直等待 ,否则就可以正常的执行,并让信号总量-1
        
        [ATBaseRequest getRequestWithMethod:@"https://www.apiopen.top/satinCommentApi?id=27610708&page=1" param:nil success:^(id data) {
            NSLog(@"3请求成功");
        } failure:^(NSInteger resultId, NSString *errorMsg) {
            
        }];
        
    });
    
}




@end
