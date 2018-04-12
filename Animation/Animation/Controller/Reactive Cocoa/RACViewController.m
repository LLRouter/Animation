//
//  RACViewController.m
//  Animation
//
//  Created by dfw on 2017/11/21.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "RACViewController.h"
#import "RACNextViewController.h"
#import "UIButton+ButtonClick.h"
//#import "RACEXTScope.h"

@interface RACViewController ()
{
    
}

@property (nonatomic, strong) RACCommand *command;

@end

typedef void(^blk_t)(void);

@implementation RACViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // reactive cocoa 数组遍历
    NSArray * numbers = @[@"1",@"2",@"3",@"4"].copy;
//    [numbers.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    RACSequence * seq = [numbers.rac_sequence map:^id(id value) {
        NSLog(@"sequence ---%@",value);
        return value;
    }];
    
    NSDictionary *dict = @{@"name ":@"lee",@"age":@"20"};
//    [dict.rac_sequence.signal subscribeNext:^(id x) {
//        RACTupleUnpack(NSString * key,NSString *value) = x;
//        //        NSString * key = x[0];
//        NSLog(@"%@ ： %@",key,value);
//    }];
    // Do any additional setup after loading the view.
//    [self  racFunctionTest];
//    [self createUI];
//    [self testBlock];
    [self testTintColor];
     [self.navigationController.navigationBar setTintColor:UIColor.redColor];
}
- (void)dealloc
{
    NSLog(@"dealloc");
}
- (void)testBlock
{
    int count = 0;
    blk_t blk = ^(){
        NSLog(@"In Stack:%d", count);
    };
    
    NSLog(@"blk's Class:%@", [blk class]);//打印：blk's Class:__NSMallocBlock__
    NSLog(@"Global Block:%@", [^{NSLog(@"Global Block");} class]);//打印：Global Block:__NSGlobalBlock__
    NSLog(@"Copy Block:%@", [[^{NSLog(@"Copy Block:%d",count);} copy] class]);//打印：Copy Block:__NSMallocBlock__
    NSLog(@"Stack Block:%@", [^{NSLog(@"Stack Block:%d",count);} class]);// Stack Block:__NSStackBlock__
    
}
- (void) racFunctionTest
{
    //处理多个请求信号，同时处理
    RACSignal *single = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber  sendNext:@"发送请求1"];
        return nil;
    }];

//    @weakify(self)
    RACSignal *single2  = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        @strongify(self)
        [subscriber sendNext:@"发送请求2"];
        return  nil;
    }];
    
    [self rac_liftSelector:@selector(updateR1:R2:) withSignalsFromArray:@[single,single2]];
}
- (void)updateR1:(id)data R2:(id)data2
{
    NSLog(@"接收到参数:%@---%@",data,data2);
}
- (void)createUI
{
    UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, MAIN_WIDTH - 20, 30)];
    field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field];
//    [field mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.topMargin.mas_equalTo(10);
//        make.leftMargin.mas_equalTo(10);
//        make.rightMargin.mas_equalTo(10);
//        make.height.mas_equalTo(30);
//    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(field.frame), CGRectGetWidth(field.frame), 20)];
    label.backgroundColor = UIColor.cyanColor;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    // rac 的属性过滤
    RAC(field, backgroundColor) = [[field.rac_textSignal map:^id(id value) {
        NSString *text = value;
        return @(text.length > 6?YES :NO);
    }] map:^id(id value) {
        return [value boolValue] ? UIColor.lightGrayColor: UIColor.clearColor;
    }];
   
    // 绑定field 和label
    RAC(label,text) = field.rac_textSignal;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  =CGRectMake(10, 300, 50, 30);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    __weak typeof(self) weak = self;
    btn.click = ^{
        __strong typeof(self) strong = weak;
        RACNextViewController *nextVc = [[RACNextViewController alloc] init];
        nextVc.subject = [RACSubject subject];
        [nextVc.subject subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
        nextVc.racVC = strong;
        [strong.navigationController pushViewController:nextVc animated:YES];
    };
    
    /// 监听某个对象的属性变化
    [RACObserve(label, text) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 添加过滤器
    [[field.rac_textSignal filter:^BOOL(id value) {
        NSString *text = value;
        return text.length > 3;
    }] subscribeNext:^(id x) {
        
    }];
    // subject 和 replaySubject 区别在于  subject要在发送信号之前订阅，不然收不到信号
    RACReplaySubject *subject = [RACReplaySubject subject];// 注册信号
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];// 发送信号
    [subject subscribeNext:^(id x) {
        NSLog(@"接收到第一个通知：%@",x);
        
    }];// 订阅信号
    
    RACSubject *single = [RACSubject subject];
    [single subscribeNext:^(id x) {
        NSLog(@"RACSubject收到信号：%@",x);
    }];
    [single sendNext:@"111"];
    
    RACSignal *bindSignal = [single bind:^RACStreamBindBlock{
       
        return ^RACSignal * (id value ,BOOL*stop){
            NSLog(@"接收到数据:%@",value);
            value = @"大傻";
            return [RACSignal return:value];
        };
    }];
    
    
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"处理过后的数据：%@",x);
    }];
    
    [single sendNext:@"123"];
    // 可以绑定多个信号量
    RACSignal *combineTest = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1111"];
        return nil;
    }] timeout:2 onScheduler:[RACScheduler scheduler]] delay:3]  ;
    //超时2s 延时3s
    [combineTest subscribeNext:^(id x) {
#if debug
        NSLog(@"%@", x);
#endif
    }];
    
    @weakify(self)
    RACSignal *combineSingle = [RACSignal combineLatest:@[field.rac_textSignal,combineTest] reduce:^id(NSString*usernameValid,NSString * test){
        return @(usernameValid.length >3 && test.length > 3);
    }];
    [combineSingle subscribeNext:^(id x) {
        @strongify(self)
        if ([x  boolValue]) {
             self.view.backgroundColor = UIColor.yellowColor;
        }else
        {
             self.view.backgroundColor = UIColor.whiteColor;
        }
    }];
    
    
    
//    _command = [[RACCommand alloc] initWithEnabled:combineSingle signalBlock:^RACSignal *(id input) {
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [subscriber sendNext:@"RACCommand"];
//            [subscriber sendNext:@"RAC1"];
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"RACCommand"];
            [subscriber sendNext:@"RAC1"];
            [subscriber sendNext:@"RAC2"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    self.command = command;
    [[_command executionSignals] subscribeNext:^(RACSignal * racCommand) {
        [racCommand subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
        
    }];
//    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
//        
//        NSLog(@"%@",x);
//    }];
    [self.command execute:@1];
}

-(void) buttonAction: (id)sender
{
    RACNextViewController *nextVc = [[RACNextViewController alloc] init];
    nextVc.subject = [RACSubject subject];
    [nextVc.subject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    nextVc.racVC = self;
    [self.navigationController pushViewController:nextVc animated:YES];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"rav" message:@"messafe" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    @weakify(self)
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(id x) {
//        RACTupleUnpack(UIAlertView *alertView, NSNumber *index) = x;
//        @strongify(self)
//        if (alert == alertView && 1 == [index integerValue]) {
//            NSLog(@"确定");
//        }else{
//            NSLog(@"取消========%lu",[index integerValue]);
//        }
//
//    }];
//
//    [alert show];
}
// bind方法使用步骤:

// 1.传入一个返回值RACStreamBindBlock的block。

// 2.描述一个RACStreamBindBlock类型的bindBlock作为block的返回值。

// 3.描述一个返回结果的信号，作为bindBlock的返回值。

// 注意：在bindBlock中做信号结果的处理。

// 底层实现:

// 1.源信号调用bind,会重新创建一个绑定信号。

// 2.当绑定信号被订阅，就会调用绑定信号中的didSubscribe，生成一个bindingBlock。

// 3.当源信号有内容发出，就会把内容传递到bindingBlock处理，调用bindingBlock(value,stop)

// 4.调用bindingBlock(value,stop)，会返回一个内容处理完成的信号（RACReturnSignal）。

// 5.订阅RACReturnSignal，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。

// 注意:不同订阅者，保存不同的nextBlock，看源码的时候，一定要看清楚订阅者是哪个。

// 这里需要手动导入#import <ReactiveCocoa/RACReturnSignal.h>，才能使用RACReturnSignal。
- (void)testTintColor
{
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(60, 100, 300, 10)];
    [slider addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}
- (void)valueChange
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    UIColor *color = [UIColor colorWithRed:hue green:saturation blue:brightness alpha:1];
//    self.view.tintColor = color;
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
   
}
@end
