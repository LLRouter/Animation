//
//  LLThreadViewController.m
//  Animation
//
//  Created by dfw on 2017/11/7.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "LLThreadViewController.h"
#import <pthread.h>

@interface LLThreadViewController ()
{
    // 互斥锁
    pthread_mutex_t _mutex;
}

@end

@implementation LLThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pthread_mutex_init(&_mutex, NULL);
    
//    // 初始化
//    int pthread_cond_init (pthread_cond_t *cond, pthread_condattr_t *attr);
//
//    // 等待（会阻塞）
//    int pthread_cond_wait (pthread_cond_t *cond, pthread_mutex_t *mut);
//
//    // 定时等待
//    int pthread_cond_timedwait (pthread_cond_t *cond, pthread_mutex_t *mut, const struct timespec *abstime);
//
//    // 唤醒
//    int pthread_cond_signal (pthread_cond_t *cond);
//
//    // 广播唤醒
//    int pthread_cond_broadcast (pthread_cond_t *cond);
//
//    // 销毁
//    int pthread_cond_destroy (pthread_cond_t *cond);
    
  
}
- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
}
- (void)getIamgeName:(NSMutableArray *)imageNames{
    NSString *imageName;
    /**
     *  加锁
     */
    pthread_mutex_lock(&_mutex);
    if (imageNames.count>0) {
        imageName = [imageNames firstObject];
        [imageNames removeObjectAtIndex:0];
    }
    /**
     *  解锁
     */
    pthread_mutex_unlock(&_mutex);
    // synchronized锁 (适用线程不多，任务量不大的多线程加锁)
//    @synchronized(self) {
//        if (imageNames.count>0) {
//            imageName = [imageNames lastObject];
//            [imageNames removeObject:imageName];
//        }
//    }
    
//    NSLock：其实NSLock并没有想象中的那么差，不知道大家为什么不推荐使用
//    dispatch_semaphore_t：使用信号来做加锁，性能提升显著
//    NSCondition：使用其做多线程之间的通信调用不是线程安全的
//    NSConditionLock：单纯加锁性能非常低，比NSLock低很多，但是可以用来做多线程处理不同任务的通信调用
//    NSRecursiveLock：递归锁的性能出奇的高，但是只能作为递归使用,所以限制了使用场景
//    NSDistributedLock：因为是MAC开发的，就不讨论了(NSDistributedLock是MAC开发中的跨进程的分布式锁，底层是用文件系统实现的互斥锁。NSDistributedLock没有实现NSLocking协议，所以没有lock方法，取而代之的是非阻塞的tryLock方法。)
//    POSIX(pthread_mutex)：底层的api，复杂的多线程处理建议使用，并且可以封装自己的多线程
//    OSSpinLock：(自旋锁)性能也非常高，可惜出现了线程问题
//    dispatch_barrier_async/dispatch_barrier_sync：测试中发现dispatch_barrier_sync比dispatch_barrier_async性能要高，真是大出意外

    
}
//栅栏函数在读写数据的时候应用
//    - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
//    {
//        dispatch_barrier_async(self.concurrentQueue, ^{
//            [self.mutableDictionary setObject:anObject forKey:aKey];
//        });
//    }
//
//    - (id)objectForKey:(id)aKey
//    {
//        __block id object = nil;
//        dispatch_sync(self.concurrentQueue, ^{
//            object = [self.mutableDictionary objectForKey:aKey];
//        });
//        return  object;
//    }
//

// 图像绘制
//- (void)displayImage
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        CGContextRef ctf = CGBitmapContextCreate(...);
//        CGImageRef cif = CGBitmapContextCreateImage(ctf);
//        CFRelease(cif);
//        dispatch_async(dispatch_get_main_queue(), ^{
//           //do something with cif
//        });
//
//    });
//}
@end
