//
//  LLBlockTool.m
//  Animation
//
//  Created by dfw on 2017/11/3.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "LLBlockTool.h"

@implementation LLBlockTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result = 0;
    }
    return self;
}
+(NSInteger)calculate:(void (^)(LLBlockTool *))make
{
    LLBlockTool * tool = [[LLBlockTool alloc] init];
    make(tool);
    return tool.result;
}
+ (instancetype)initWithType:(NSInteger )type addBlock:(void(^)(NSString * str))addBlock
{
    return [[self alloc] init];
}
- (Calculate)add
{
    return ^LLBlockTool *(NSInteger num) {
        self.result += num;
       return self;
    };
}
- (LLBlockTool *(^)(NSInteger num))minus
{
    return ^LLBlockTool *(NSInteger num){
        self.result -= num;
        return self;
    };
}
- (LLBlockTool *(^)(NSInteger num))multiply
{
    return ^LLBlockTool *(NSInteger num){
        self.result *= num;
        return self;
    };
}
//在以下情形中， block 会从栈拷贝到堆：
//
//当 block 调用 copy 方法时，如果 block 在栈上，会被拷贝到堆上；
//当 block 作为函数返回值返回时，编译器自动将 block 作为 _Block_copy 函数，效果等同于 block 直接调用 copy 方法；
//当 block 被赋值给 __strong id 类型的对象或 block 的成员变量时，编译器自动将 block 作为 _Block_copy 函数，效果等同于 block 直接调用 copy 方法；
//当 block 作为参数被传入方法名带有 usingBlock 的 Cocoa Framework 方法或 GCD 的 API 时。这些方法会在内部对传递进来的 block 调用 copy 或 _Block_copy 进行拷贝;

@end
