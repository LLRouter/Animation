//
//  RACNextViewController.m
//  Animation
//
//  Created by dfw on 2017/11/21.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "RACNextViewController.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface RACNextViewController ()

@end

typedef void (*_IMP)(id,SEL,...);

@implementation RACNextViewController

//http://www.jianshu.com/p/927c8384855a runtime
/// 编译的时候就会替换，所以要保证方法只被替换一次
+ (void)load{
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(viewWillAppear:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(swiz_viewWillAppear:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }

    });
}

- (void)swiz_viewWillAppear:(BOOL)animated{
    //这时候调用自己，看起来像是死循环
    //但是其实自己的实现已经被替换了
    [self swiz_viewWillAppear:animated];
    NSLog(@"swizzle");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *dict = @{@"key1":@"111",@"key2":@"222"};
//    [self performSelector:@selector(addMethod:) withObject:dict withObject:@"11111"];
//    [self testRegisterClasspair];
//    [self runtimeCheck];
    
//    [self learnMethod];
 //      [self testGcd];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    [array addObject:@"测试"];
    
   ((void(*)(id,SEL))objc_msgSend)(self,@selector(testGcd));
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.subject) {
         [_subject sendNext:@"Child view disappear"];
    }
}
// 方法拦截
void runAddMethod(id self,SEL _cmd,NSDictionary * dict,NSString * string1){
    NSLog(@"%@...%@",dict,string1);
}
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    // v@ 表示没有参数的方法  v@: 表示含参数的方法
    if ([NSStringFromSelector(sel) isEqualToString:@"addMethod:"]) {
        class_addMethod(self, sel, (IMP)runAddMethod, "v@:");
    }
    return YES;
}
//-(void)forwardInvocation:(NSInvocation *)invocation
//{
//    SEL invSEL = invocation.selector;
//
//    if([altObject respondsToSelector:invSEL]) {
//        [invocation invokeWithTarget:altObject];
//    } else {
//        [self doesNotRecognizeSelector:invSEL];
//    }
//}

void TestNewClass(id self ,SEL _cmd){
    NSLog(@"Class is %@,superClass is %@",[self class],[self superclass]);
}
-(void)testRegisterClasspair
{
//    Method method = class_getInstanceMethod([self class], NSSelectorFromString(@"runAddMethod:"));
//    const char *type = method_getTypeEncoding(method);
//    NSString *c = [NSString stringWithUTF8String:type];
//    NSLog(@"%@",c);
    Class newClass = objc_allocateClassPair([UIView class], "TestClass", 0);
    class_addMethod(newClass,NSSelectorFromString(@"testNewClass"), (IMP)TestNewClass, "v@");
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    [instance performSelector:@selector(testNewClass) withObject:nil];
}
- (void)runtimeCheck{
unsigned int count;
//获取属性列表
objc_property_t *propertyList = class_copyPropertyList([self class], &count);
for (unsigned int i=0; i<count; i++) {
    const char *propertyName = property_getName(propertyList[i]);
    NSString * property = [NSString stringWithUTF8String:propertyName];
    id value = [self valueForKey:property];
    NSLog(@"property---->%@", value);
}
    free(propertyList);
//
////获取方法列表
//Method *methodList = class_copyMethodList([self class], &count);
//for (unsigned int i; i<count; i++) {
//    Method method = methodList[i];
//    NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
//}
//free(methodList)
////获取成员变量列表（_xxx）
Ivar *ivarList = class_copyIvarList([self class], &count);
for (unsigned int i = 0; i<count; i++) {
    Ivar myIvar = ivarList[i];
    const char *ivarName = ivar_getName(myIvar);
    NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
}
    free(ivarList);
////获取协议列表
//__unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
//for (unsigned int i; i<count; i++) {
//    Protocol *myProtocal = protocolList[i];
//    const char *protocolName = protocol_getName(myProtocal);
//    NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
//}
//free(protocolList)
}
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
- (void)learnMethod
{
    SEL sel = @selector(runtimeCheck);
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:sel];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = sel;
    [invocation invoke];
}
- (void)operationQueue
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *blo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1111");
    }];
    ///[blo start] 直接调用是在主线程执行
    //blo addExecutionBlock:<#^(void)block#> block添加的是子线程执行
    [queue addOperation:blo];
    
    NSOperationQueue * queue2 = [NSOperationQueue mainQueue];
    [queue2 addOperationWithBlock:^{
        
    }];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(learnMethod) object:nil];
    [thread start];
    [NSThread detachNewThreadWithBlock:^{
      
    }];
//    [self performSelectorInBackground:<#(nonnull SEL)#> withObject:<#(nullable id)#>]
//    [self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>]
}
- (void)testGcd
{
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("test1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
         sleep(3);
        NSLog(@"1111");
      
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"-----");
    });
    dispatch_async(queue, ^{
        NSLog(@"22222");
    });
    // 栅栏函数对同一队列的方法起作用
}


//二、消息调用流程
//一切还是从消息表达式[receiver message]开始，在被转换成objc_msgSend(receiver, SEL)后，在运行时，runtime system会做以下事情：
//
//1、检查忽略的Selector，比如当我们运行在有垃圾回收机制的环境中，将会忽略retain和release消息。
//
//2、检查receiver是否为nil。不像其他语言，nil在objective-C中是完全合法的，并且这里有很多原因你也愿意这样，比如，至少我们省去了给一个对象发送消息前检查对象是否为空的操作。如果receiver为空，则会将 selector也设置为空，并且直接返回到消息调用的地方。如果对象非空，就继续下一步。
//
//3、接下来会根据SEL到当前类中查找对应的IMP，首先会在cache中检索它，如果找到了就根据函数指针跳转到这个函数执行，否则进行下一步。
//
//4、检索当前类对象中的方法表（method list），如果找到了，加入cache中，并且就跳转到这个函数之行，否则进行下一步。
//
//5、从父类中寻找,直到根类：NSObject类。找到了就将方法加入对应类的cache表中，如果仍为找到，则要进入后文介绍的内容：动态方法决议。
//
//6、如果动态方法决议仍不能解决问题，只能进行最后一次尝试，进入消息转发流程。
// Method
//typedef struct objc_method *Method;
//
//struct objc_method {
//    SEL method_name                                          OBJC2_UNAVAILABLE;
//    char *method_types                                       OBJC2_UNAVAILABLE;
//    IMP method_imp                                           OBJC2_UNAVAILABLE;
//}
//objc_method 存储了方法名，方法类型和方法实现：
//
//方法名类型为 SEL
//方法类型 method_types 是个 char 指针，存储方法的参数类型和返回值类型
//method_imp 指向了方法的实现，本质是一个函数指针

//No1：可变对象的copy和mutableCopy方法都是深拷贝（区别完全深拷贝与单层深拷贝） 。
//
//　   No2：不可变对象的copy方法是浅拷贝，mutableCopy方法是深拷贝。
//
//　   No3：copy方法返回的对象都是不可变对象。

//如何判断传入的是类而不是对象：class_isMetaClass(object_getClass(self)))，object_getClass是获取当前对象由什么实例化。

//COCOAPODS
//sudo gem install cocoapods
//pod setup --verbose
//cd ~/Path/To/Folder/Containing/IceCreamShop
//如果第一次没有podfile  pod init
//open -a Xcode Podfile
//pod 'Alamofire', '4.4.0'
//pod install
@end
