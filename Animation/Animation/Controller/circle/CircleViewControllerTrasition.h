//
//  CircleViewControllerTrasition.h
//  Animation
//
//  Created by dfw on 2017/11/2.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , CircleViewControllerTrasitionType) {
    CircleViewControllerTrasitionPresent = 0,
    CircleViewControllerTrasitionDismiss,
};

@interface CircleViewControllerTrasition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)circleViewControllerTransition:(CircleViewControllerTrasitionType)type;
- (instancetype)initCircleViewControllerTransition:(CircleViewControllerTrasitionType) type;

@end
