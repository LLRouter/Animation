//
//  CircleViewControllerTrasition.m
//  Animation
//
//  Created by dfw on 2017/11/2.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "CircleViewControllerTrasition.h"
#import "CircleViewController.h"

@interface CircleViewControllerTrasition()<CAAnimationDelegate>

@property (nonatomic, assign)CircleViewControllerTrasitionType type;

@end

@implementation CircleViewControllerTrasition

+(instancetype)circleViewControllerTransition:(CircleViewControllerTrasitionType)type
{
    return [[self alloc] initCircleViewControllerTransition:type];
}
- (instancetype)initCircleViewControllerTransition:(CircleViewControllerTrasitionType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case CircleViewControllerTrasitionPresent:
            [self transitionPresent:transitionContext];
            break;
        case CircleViewControllerTrasitionDismiss:
            [self transitionDismiss:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return CircleViewControllerTrasitionPresent == _type ? 0.5:0.5;
}
- (void)transitionPresent:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CircleViewController *circleVc = fromVc.viewControllers.lastObject;
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    
    UIBezierPath * startPath = [UIBezierPath bezierPathWithOvalInRect:circleVc.buttonFrame ];
    
    CGFloat x = MAX(circleVc.buttonFrame.origin.x, toVc.view.frame.size.width - circleVc.buttonFrame.origin.x);
    CGFloat y = MAX(circleVc.buttonFrame.origin.y, toVc.view.frame.size.height - circleVc.buttonFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = endPath.CGPath;
    toVc.view.layer.mask = layer;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
    
}
- (void)transitionDismiss:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController  * toVc = (UINavigationController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CircleViewController *circleVc = toVc.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height +  containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath * startCirclePath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    UIBezierPath * endCirclePath = [UIBezierPath bezierPathWithOvalInRect:circleVc.buttonFrame];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = startCirclePath.CGPath;
    layer.fillColor = [UIColor blueColor].CGColor;
    fromVc.view.layer.mask = layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startCirclePath.CGPath;
    animation.toValue = (__bridge id)endCirclePath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case CircleViewControllerTrasitionPresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            //            [transitionContext viewControllerForKey:UITransitionContextToViewKey].view.layer.mask = nil;
        }
            break;
        case CircleViewControllerTrasitionDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
    }
}
@end
