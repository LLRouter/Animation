//
//  LLTimerManager.h
//  Animation
//
//  Created by Mr.L on 2018/12/10.
//  Copyright © 2018 东方网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLTimerManager : NSObject

+(id)shareInstance;
-(CADisplayLink *)createTimer: (void (^)(void))timeRun;
- (void)releaseTimer:(CADisplayLink *)link;
/**  */
@property(nonatomic, copy)void (^timeRun)(void);

@end

