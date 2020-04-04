//
//  CADisplayLink+LSLinkManager.m
//  Animation
//
//  Created by Mr.L on 2018/12/11.
//  Copyright © 2018 东方网. All rights reserved.
//

#import "CADisplayLink+LSLinkManager.h"
#import <objc/runtime.h>

@implementation CADisplayLink (LSLinkManager)
-(void)setRun:(void (^)(void))run{
    objc_setAssociatedObject(self, "LSLinkBlock", run, OBJC_ASSOCIATION_COPY);
}
- (void (^)(void))run{
   return  objc_getAssociatedObject(self, "LSLinkBlock");
}
+(CADisplayLink *)ls_displayLinkWithTimeInterval:(NSInteger)frameInterval run:(void(^)(void))run{
    CADisplayLink * link = [self displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
    link.frameInterval  = frameInterval;
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    link.run = run;
    return link;
}
+ (void)displayLinkAction:(CADisplayLink *)link{
    if (link.run) {
       link.run();
    }
}


@end
