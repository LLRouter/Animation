//
//  CircleViewController.m
//  Animation
//
//  Created by dfw on 2017/11/2.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleNextViewController.h"
#import "AFNetworking.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    imageV.image = [UIImage imageNamed:@"pic1.jpg"];
    [self.view addSubview:imageV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"推出视图" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 150, 100, 100);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [btn addGestureRecognizer:pan];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
//    manager.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
//    [manager.requestSerializer setValue:@"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0MTMzODYxMzg1NDAwNjE0OTEyIiwiYXVkIjpbInVzZXJUeXBlOkN1c3RvbWVycyIsInRva2VuVHlwZTphY2Nlc3NUb2tlbiJdLCJpc3MiOiIqLmhpZ2hsYW5kcy5sdGQiLCJleHAiOjE1NTQyOTY2NzV9.zyFURqdJszz462Phu39rZaqn3ES2_BTdmy_x6I59K6Y" forHTTPHeaderField:@"Authorization"];
//    [manager PUT:@"http://jxb-api.test.highlands.ltd/api/v1/tenant/1/app/course/feedback" parameters:@{@"feedbackType":@"1",@"content":@"12312"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"成功");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败");
//    }];
}
- (CGRect)buttonFrame
{
    return CGRectMake(100, 150, 100, 100);
}
- (void)present
{
    CircleNextViewController *circleVc = [[CircleNextViewController alloc] init];
    [self presentViewController:circleVc animated:YES completion:nil];
}
- (void)pan:(UIPanGestureRecognizer *)panGesture{
    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x - [UIScreen mainScreen].bounds.size.width / 2, [panGesture translationInView:panGesture.view].y + button.center.y - [UIScreen mainScreen].bounds.size.height / 2);
 //   [button mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(newCenter).priorityLow();
//    }];
    button.center = newCenter;
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}
@end
