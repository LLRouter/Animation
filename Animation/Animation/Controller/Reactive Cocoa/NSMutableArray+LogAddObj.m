//
//  NSMutableArray+LogAddObj.m
//  Animation
//
//  Created by dfw on 2017/12/8.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "NSMutableArray+LogAddObj.h"
#import <objc/runtime.h>

@implementation NSMutableArray (LogAddObj)
+(void)load
{
// __NSArrayM是NSMutableArray的的真实类型 如果用self 导致替换失败
    
        Method addObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
        Method logAddObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(logAddObj:));
    
//        BOOL isAdd = class_addMethod(NSClassFromString(@"__NSArrayM") , @selector(addObject:), method_getImplementation(logAddObject), method_getTypeEncoding(logAddObject));
//        if (isAdd) {
//            class_replaceMethod(NSClassFromString(@"__NSArrayM"), @selector(logAddObj:), method_getImplementation(addObject), method_getTypeEncoding(addObject));
//        }else{
            method_exchangeImplementations(addObject, logAddObject);
 //       }
}

- (void)logAddObj:(id)object
{
//    NSLog(@"add obj:%@ to  array",object);
    [self logAddObj:object];
}
@end
