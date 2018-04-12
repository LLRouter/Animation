//
//  LLInterActiveTransition.h
//  Animation
//
//  Created by dfw on 2017/11/1.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConfig)();
/**
 判断手势方向
 */
typedef NS_ENUM(NSInteger,LLInterActiveTransitionGestureDirection)
{
    LLInteractiveTransitionGeastureDirectionLeft = 0,
    LLInteractiveTransitionGeastureDirectionRight,
    LLInteractiveTransitionGeastureDirectionUp,
    LLInteractiveTransitionGeastureDirectionDown
};

/**
 判断页面切换方式
 */
typedef NS_ENUM(NSInteger,LLInterActionTransitonType) {
    LLInteracitontransitionTypePresent = 0,
    LLInteracitontransitionTypePush,
    LLInteracitontransitionTypeDismiss,
    LLInteracitontransitionTypePop
};

@interface LLInterActiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign)BOOL interation;

@property (nonatomic, copy)GestureConfig presentConfig;

@property (nonatomic, copy)GestureConfig pushConfig;

+(instancetype)interactiveTransitionWithType:(LLInterActionTransitonType) type GestureDirection:(LLInterActiveTransitionGestureDirection )direction;

-(instancetype) initInteractiveTransitionType:(LLInterActionTransitonType)type GestureDirection:(LLInterActiveTransitionGestureDirection) direction;

- (void)addGestureForViewController:(UIViewController *)controller;
@end
