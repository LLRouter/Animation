//
//  LLTimerManager.m
//  Animation
//
//  Created by Mr.L on 2018/12/10.
//  Copyright © 2018 东方网. All rights reserved.
//

#import "LLTimerManager.h"

@interface LLTimerManager ()

    /**  */
@property(nonatomic, strong)CADisplayLink *link;
    
@end

@implementation LLTimerManager

+(id)shareInstance{
    static LLTimerManager * timer = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        timer = [[self alloc] init];
    });
    return timer;
}

-(CADisplayLink *)createTimer: (void (^)(void))timeRun{
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction)];
    _link.frameInterval = 5;
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _timeRun = [timeRun copy];
    return self.link;
}
- (void)timerAction{
    if (_timeRun) {
        _timeRun();
    }
}
- (void)releaseTimer:(CADisplayLink *)link{
    if (link) {
        [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [link invalidate];
    }
}

@end
