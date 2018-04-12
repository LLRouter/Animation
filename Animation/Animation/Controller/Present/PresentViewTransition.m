//
//  presentViewTransition.m
//  Animation
//
//  Created by dfw on 2017/11/1.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "presentViewTransition.h"

@interface PresentViewTransition()

@property(nonatomic, assign) PresentTransitionType type;

@end

@implementation PresentViewTransition

- (instancetype)initWithTransitionType:(PresentTransitionType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
+(instancetype)transitionWithType:(PresentTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case PresentTransitionTypeDismiss:
            [self dismissAnimaiton:transitionContext];
            break;
        case PresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return _type == PresentTransitionTypePresent ? 0.5:0.25;
}
- (void)presentAnimation:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *snapshot = [fromVc.view snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = fromVc.view.frame;
    fromVc.view.hidden = YES;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:snapshot];
    [containerView addSubview:toVc.view];
    
    toVc.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, MAIN_HEIGHT - 200);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        toVc.view.transform = CGAffineTransformMakeTranslation(0, - (MAIN_HEIGHT - 200));
        snapshot.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            fromVc.view.hidden = NO;
            [snapshot removeFromSuperview];
        }
    }];
}
- (void)dismissAnimaiton:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    NSArray *subViews = containerView.subviews;
    UIView *snapshot = subViews[MIN(subViews.count, MAX(0, subViews.count - 2))];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        snapshot.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了接标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [snapshot removeFromSuperview];
        }
    }];
    
}
@end
