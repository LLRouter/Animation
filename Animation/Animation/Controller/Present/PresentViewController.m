//
//  PresentViewController.m
//  Animation
//
//  Created by dfw on 2017/10/31.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "PresentViewController.h"
#import "PresentNextViewController.h"

@interface PresentViewController ()<PresentNextViewControllerDelegate>

@property (nonatomic,strong) LLInterActiveTransition * interactivePresent;



@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    imageV.image = [UIImage imageNamed:@"pic1.jpg"];
    [self.view addSubview:imageV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"推出视图" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 150, 100, 20);
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.top.equalTo(@30);
//        make.size.mas_equalTo(CGSizeMake(40, 20));
//    }];
    _interactivePresent = [LLInterActiveTransition interactiveTransitionWithType:LLInteracitontransitionTypePresent GestureDirection:LLInteractiveTransitionGeastureDirectionUp];
    __weak typeof(self)weakSelf = self;
    _interactivePresent.presentConfig = ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf present];
    };
    [_interactivePresent addGestureForViewController:self.navigationController];
 
}
- (void)present
{
    PresentNextViewController *pvc = [[PresentNextViewController alloc] init];
    pvc.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pvc];
    nav.transitioningDelegate = pvc;
    pvc.delegateSingle = [RACSubject subject];
    [pvc.delegateSingle subscribeNext:^(id x) {
        NSLog(@"%s",__func__);
    }];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)presentViewNextControllerDissmiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(id<UIViewControllerInteractiveTransitioning>)interactiveTransitionPresent
{
    return _interactivePresent;
}
- (void)dealloc
{
    NSLog(@"self has been dealloc!");
}


@end
