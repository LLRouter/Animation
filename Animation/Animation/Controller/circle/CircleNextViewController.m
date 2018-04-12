//
//  CircleNextViewController.m
//  Animation
//
//  Created by dfw on 2017/11/2.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "CircleNextViewController.h"
#import "CircleViewControllerTrasition.h"

@interface CircleNextViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) LLInterActiveTransition *interacitonTransition;

@end

@implementation CircleNextViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    imageV.image = [UIImage imageNamed:@"pic2.jpeg"];
    [self.view addSubview:imageV];
    
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击退出" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 200, 80, 20);
   [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.interacitonTransition addGestureForViewController:self];
   
}
- (LLInterActiveTransition *)interacitonTransition
{
    if (!_interacitonTransition) {
        _interacitonTransition = [LLInterActiveTransition interactiveTransitionWithType:LLInteracitontransitionTypeDismiss GestureDirection:LLInteractiveTransitionGeastureDirectionDown];
    }
    return _interacitonTransition;
}
- (void)btnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [CircleViewControllerTrasition circleViewControllerTransition:CircleViewControllerTrasitionDismiss];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [CircleViewControllerTrasition circleViewControllerTransition:CircleViewControllerTrasitionPresent];
}
-  (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator

{
    return _interacitonTransition.interation?_interacitonTransition :nil;
}
@end
