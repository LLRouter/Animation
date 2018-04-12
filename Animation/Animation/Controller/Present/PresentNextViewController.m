//
//  PresentNextViewController.m
//  Animation
//
//  Created by dfw on 2017/10/31.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "PresentNextViewController.h"
#import "presentViewTransition.h"
#import "LLBlockTool.h"
#import "MathTest.h"

@interface PresentNextViewController ()

@property (nonatomic,strong) LLInterActiveTransition * interactiveDismiss;
@property (nonatomic,strong) LLInterActiveTransition * interactivePush;

@end

@implementation PresentNextViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
 //       self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        // 自定义转场的时候必须设置custom不然 不起作用
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 200, 30);
    
    _interactiveDismiss = [LLInterActiveTransition interactiveTransitionWithType:LLInteracitontransitionTypeDismiss GestureDirection:LLInteractiveTransitionGeastureDirectionDown];
    [_interactiveDismiss addGestureForViewController:self];
    
    //oc 的链式语法 实际上是用block 实现
    LLBlockTool *tool = [[LLBlockTool alloc] init];
    tool.add(5).minus(3).multiply(2);
    NSLog(@"----%ld",(long)tool.result);
    __weak typeof(tool) weak = tool;
    [tool setTest:^LLBlockTool *(NSString *str) {
        __strong typeof(weak) strong = weak;
        strong.minus(11);
        NSLog(@"----%ld",(long)strong.result);
        return strong;
    }];
    tool.test(@"111");
    NSInteger result = [LLBlockTool calculate:^(LLBlockTool *make) {
        make.add(5).minus(6).multiply(2);
    }];
    NSLog(@"----Block Tool:%ld",(long)result);
//    __weak  __typeof(self)weakSelf = self;
//    LLBlockTool *block = [LLBlockTool initWithType:0
//                                                  addBlock:^(NSString *str) {
//                                                      [weakSelf dismiss];
//                                                  }];
//    MathTest * math = [[MathTest alloc] init];
//    BOOL isEqual =  [[[math calculate:^int(int result) {
//        result += 2;
//        result *= 5;
//        return result;
//    }] equal:^BOOL(int result) {
//        return result == 10;
//    }] isEqual] ;
//    NSLog(@"----Math Tool:%d", isEqual);
}
- (void)dealloc
{
    NSLog(@"self has been dealloc!");
}

- (void)dismiss{
    
    if (self.delegateSingle) {
        [self.delegateSingle sendNext:nil];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(presentViewNextControllerDissmiss)]) {
        [_delegate presentViewNextControllerDissmiss];
    }
}
#pragma mark --- transition Delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [PresentViewTransition transitionWithType:PresentTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [PresentViewTransition transitionWithType:PresentTransitionTypeDismiss];
}

#pragma mark --- animation Delegate
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveDismiss.interation ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    LLInterActiveTransition *interactivePresent = [_delegate interactiveTransitionPresent];
    return interactivePresent.interation ? interactivePresent : nil;
}

@end
