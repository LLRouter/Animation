//
//  UIButton+ButtonClick.m
//  Animation
//
//  Created by dfw on 2017/12/7.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "UIButton+ButtonClick.h"
#import <objc/runtime.h>

@implementation UIButton (ButtonClick)
- (void)setClick:(buttonClick)click
{
    objc_setAssociatedObject(self, @"BUTTON_CLICK", click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    if (click) {
        [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (buttonClick)click
{
    return objc_getAssociatedObject(self, @"BUTTON_CLICK");
}
- (void)buttonClicked
{
    if (self.click) {
        self.click();
    }
}
// 类别里面使用定义的属性，通过runtime 动态绑定
@end
