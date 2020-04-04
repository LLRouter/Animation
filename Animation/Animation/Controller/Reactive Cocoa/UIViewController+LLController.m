//
//  UIViewController+LLController.m
//  Animation
//
//  Created by dfw on 2018/1/4.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "UIViewController+LLController.h"
#import "Aspects.h"

@implementation UIViewController (LLController)
+(void)load
{
//    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
//            NSLog(@"aspect view will appear--- %@--%@---%@",aspectInfo.instance,aspectInfo.originalInvocation,aspectInfo.arguments);
//        if ([aspectInfo.instance isKindOfClass:[UIViewController class]]) {
//            UIViewController *hookVc = (UIViewController *)aspectInfo.instance;
//         }
//    } error:nil];
}
// 类方法的拦截
//Class catMetal = objc_getMetaClass(NSStringFromClass(Cat.class).UTF8String);
//
//    [catMetal aspect_hookSelector:@selector(classFee) withOptions:AspectPositionAfter usingBlock:^(id aspectInfo){
//
//               NSLog(@"aspectFee");
//
//         } error:NULL];
@end
