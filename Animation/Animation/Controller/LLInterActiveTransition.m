//
//  LLInterActiveTransition.m
//  Animation
//
//  Created by dfw on 2017/11/1.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "LLInterActiveTransition.h"

@interface LLInterActiveTransition()

@property (nonatomic,weak)UIViewController *vc;// 这里使用weak 是为了防止内存泄露
@property (nonatomic, assign)LLInterActionTransitonType type;
@property (nonatomic, assign)LLInterActiveTransitionGestureDirection direction;

@end

@implementation LLInterActiveTransition
+(instancetype)interactiveTransitionWithType:(LLInterActionTransitonType)type GestureDirection:(LLInterActiveTransitionGestureDirection)direction
{
    return [[self alloc] initInteractiveTransitionType:type GestureDirection:direction];
}
- (instancetype)initInteractiveTransitionType:(LLInterActionTransitonType)type GestureDirection:(LLInterActiveTransitionGestureDirection)direction
{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return  self;
}
- (void)addGestureForViewController:(UIViewController *)controller
{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    self.vc = controller;
    [controller.view addGestureRecognizer:panGes];
}
- (void)panAction:(UIPanGestureRecognizer *)panGes
{
    CGFloat present = 0;
    switch (_direction) {
        case LLInteractiveTransitionGeastureDirectionLeft:{
            CGFloat postionX = -[panGes translationInView:panGes.view].x;
            present = postionX / panGes.view.frame.size.width;
        }
            break;
        case LLInteractiveTransitionGeastureDirectionRight:{
            CGFloat positionX = [panGes translationInView:panGes.view].x;
            present = positionX / panGes.view.frame.size.width;
        }
            break;
        case LLInteractiveTransitionGeastureDirectionUp:{
            CGFloat  positionY = - [panGes translationInView:panGes.view].y;
            present = positionY / panGes.view.frame.size.width;
        }
            break;
        case LLInteractiveTransitionGeastureDirectionDown:{
            CGFloat  positionY =  [panGes translationInView:panGes.view].y;
            present = positionY / panGes.view.frame.size.width;
        }
            break;
    }
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan:
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:present];
            break;
        case UIGestureRecognizerStateEnded:
            self.interation = NO;
            if (present > 0.5) {
                [self finishInteractiveTransition];
            }else
            {
                [self cancelInteractiveTransition];
            }
            break;
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateFailed:
   
            break;
    }
}
- (void)startGesture
{
    switch (_type) {
        case LLInteracitontransitionTypePush:
            if (_pushConfig) {
                _pushConfig();
            }
            break;
        case LLInteracitontransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
        case LLInteracitontransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case LLInteracitontransitionTypePresent:
            if (_presentConfig) {
                _presentConfig();
            }
            break;
            
    }
}
@end
