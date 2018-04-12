//
//  ViewController.m
//  Animation
//
//  Created by dfw on 2017/9/14.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "RootViewController.h"
#import "PresentViewController.h"
#import "CircleViewController.h"
#import "LLTextViewController.h"
#import "RACViewController.h"
#import <objc/runtime.h>
#import "Aspects.h"
#import "ArithmeticViewController.h"
#import <WAAppRouting/WAAppRouting.h>

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) dispatch_source_t timer;
@property (nonatomic) UILabel *label;
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *(^test)(id num,NSString * str);

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.layer.cornerRadius = 10;
    self.navigationController.view.layer.masksToBounds = YES;
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setBarTintColor:UIColor.orangeColor];
//    self.navigationController.hidesBarsOnSwipe = YES;
    self.title = @"ROOT VIEW CONTROLLER";
    
    [self creatTable];
    //[self createView];
    //  [self labelMade];
    // [self imageLabel];
    // Do any additional setup after loading the view, typically from a nib.、
    [self testBlock];
    [self.tabelView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    [self getAllFontName];

//    [self getAllProperty: [UINavigationBar class]];
//    [self getAllFunction: [UINavigationBar class]];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
//    if ([keyPath isEqualToString:@"contentOffset"]) {
//        if ([object isKindOfClass:[self.tabelView class]]) {
            CGFloat offset = self.tabelView.contentOffset.y;
            CGFloat delta = offset / 64.f + 1.f;
            delta = MAX(0, delta);
    CGFloat min = MIN(1, delta);
    SEL centerSelector = NSSelectorFromString(@"_setBackgroundOpacity:");
    if ([self.navigationController.navigationBar respondsToSelector:centerSelector]){
        NSMethodSignature *signature = [[UINavigationBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self.navigationController.navigationBar];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&min atIndex:2];// 0 是id 1 是SEL index从2开始才是参数
        [invocation invoke];
    }
    
//    [self.navigationController.navigationBar setValue:@(min) forKey:@"_backgroundOpacity"];
}
- (void)getAllProperty:(Class )class {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"Property Name : %@",name);
    }
    free(properties);
}

- (void)getAllFunction:(Class )class{
    unsigned int count;
    Method *methods = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++){
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        const char *type =  method_getTypeEncoding(method);
        NSLog(@"Function Name: %@ Type: %s",name,type);
    }
    free(methods);
}
- (void)getAllFontName
{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
        
    }
}
- (void)dealloc
{
    [self.tabelView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)testBlock
{
    // arc 情况下block 基本都在堆上
    void (^aBlock)(void) = nil;
    if (!aBlock) {
        aBlock = ^{
            NSLog(@"hehehehe");
        };
    }
    //mrc block此时block已经被释放,该处留下了一个dangling pointer
    aBlock();
//    NSString * (^testBlock)(NSString *,id) = ^NSString *(NSString* str,id num){
//        return @"1111";
//    };
//    NSLog(@"%@", testBlock(@"111",@2)) ;
   
}

- (NSString *(^)(NSString *)) resultBlcok{
    return  ^NSString *(NSString *num){
        return self.label.text;
    };
}
- (void)creatTable
{
    self.tabelView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"Present视图",@"字体",@"CirclePresent",@"Reactive Cocoa",@"Arithmetic"]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
//    cell.textLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:17];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc ;
    switch (indexPath.row) {
        case 0:
            vc = [[PresentViewController alloc] init];
            break;
        case 1:
            vc = [LLTextViewController new];
            break;
        case 2:
            vc  =[[CircleViewController alloc] init];
            break;
        case 3:
            vc  =[[RACViewController alloc] init];
            break;
        case 4 :
            vc = [ArithmeticViewController new];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static CustomCell *cell;
//
//       //只初始化一次cell
//
//       static dispatch_once_t onceToken;
//
//       dispatch_once(&onceToken, ^{
//
//               cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomCell class])];
//
//           });
//
//       DataModel *model = self.dataArray[(NSUInteger) indexPath.row];
//
//       [cell makeupData:model];
//
//
//
//       if (model.cellHeight <= 0) {
//
//               //使用systemLayoutSizeFittingSize获取高度
//
//               model.cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
//
//           }
//
//       return model.cellHeight;
//
//}
- (void)createView
{
//    CAGradientLayer *graidentLayer = [CAGradientLayer layer];
//    graidentLayer.frame = CGRectMake(20, 40, 200, 300);
//    graidentLayer.startPoint = CGPointMake(0, 0);
//    graidentLayer.endPoint = CGPointMake(0, 1);
//    graidentLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                             (__bridge id)[UIColor greenColor].CGColor,
//                             (__bridge id)[UIColor yellowColor].CGColor,
//                             (__bridge id)[UIColor blueColor].CGColor
//                             ];
//    graidentLayer.locations = @[@(0.2),@(0.4),@(0.6),@(0.8)];
//    graidentLayer.type = kCAGradientLayerAxial;
//    [self.view.layer addSublayer:graidentLayer];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
//    gradientLayer1.frame    =CGRectMake(50, MAIN_HEIGHT - 300, MAIN_WIDTH - 100, 100);
    gradientLayer1.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    
    gradientLayer1.locations  = @[@(0.0),@(1.0)];
    gradientLayer1.type = kCAGradientLayerAxial;
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint   = CGPointMake(0, 0);
   
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, MAIN_WIDTH - 100, MAIN_HEIGHT- 200)];
    imagev.image = [UIImage imageNamed:@"pic1.jpg"];
    [self.view addSubview:imagev];
    [self.view.layer addSublayer:gradientLayer1];
    
    gradientLayer1.frame = CGRectMake(50, 0, MAIN_WIDTH - 100,10);
    
    imagev.layer.shadowColor = [UIColor blackColor].CGColor;
    imagev.layer.shadowOffset = CGSizeMake(5,5);
    imagev.layer.shadowRadius =  10;
    imagev.layer.shadowOpacity = 0.5;
    
    //dispatch_queue_t queue = dispatch_queue_create("Timer for self", DISPATCH_QUEUE_SERIAL_INACTIVE);
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 8.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
 //      [self addAnimation:gradientLayer1];
    });
    dispatch_resume(_timer);
}
- (void)addAnimation:(CALayer *)layer
{
    CABasicAnimation *moveAnimaton = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveAnimaton.fromValue = @(0);
    moveAnimaton.toValue = @(MAIN_HEIGHT- 200);
    moveAnimaton.duration = 4.0;
//    moveAnimaton.repeatCount = 10;
    [layer addAnimation:moveAnimaton forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation *upanimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        upanimation.fromValue = @(MAIN_HEIGHT - 200);
        upanimation.toValue = @(0);
        upanimation.duration = 4.0;
        [layer addAnimation:upanimation forKey:nil];
    });
}
- (void)imageLabel
{
    //创建一个普通的Label
    UILabel *testLabel = [[UILabel alloc] init];
    //中央对齐
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.backgroundColor = [UIColor purpleColor];
    testLabel.numberOfLines = 0;
    testLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 300);
    [self.view addSubview:testLabel];
    
    //设置Attachment
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    //使用一张图片作为Attachment数据
    attachment.image = [UIImage imageNamed:@"pic1.jpg"];
    //这里bounds的x值并不会产生影响
    attachment.bounds = CGRectMake(-600, 0, 20, 10);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"这是一串字"];
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    testLabel.attributedText = attributedString;
}

@end
