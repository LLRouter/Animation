//
//  LLBlockTool.h
//  Animation
//
//  Created by dfw on 2017/11/3.
//  Copyright © 2017年 东方网. All rights reserved.
//
//链式编程
#import <Foundation/Foundation.h>

@interface LLBlockTool : NSObject

typedef  LLBlockTool *(^testBlock)(NSString *str);

typedef  LLBlockTool *(^Calculate)(NSInteger);

@property (nonatomic, assign) NSInteger result;

@property (nonatomic, copy) Calculate add;
@property (nonatomic, copy, readonly) LLBlockTool *(^minus)(NSInteger num);
@property (nonatomic, copy, readonly) LLBlockTool *(^multiply)(NSInteger num);
@property (nonatomic, copy) testBlock test;

+ (instancetype)initWithType:(NSInteger )type addBlock:(void(^)(NSString * str))addBlock;
+ (NSInteger)calculate:(void(^)(LLBlockTool *))make;
@end
