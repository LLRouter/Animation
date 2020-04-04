//
//  CADisplayLink+LSLinkManager.h
//  Animation
//
//  Created by Mr.L on 2018/12/11.
//  Copyright © 2018 东方网. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CADisplayLink (LSLinkManager)


@property (nonatomic, copy) void(^run)(void);
+(CADisplayLink *)ls_displayLinkWithTimeInterval:(NSInteger)frameInterval run:(void(^)(void))run;


@end

NS_ASSUME_NONNULL_END
