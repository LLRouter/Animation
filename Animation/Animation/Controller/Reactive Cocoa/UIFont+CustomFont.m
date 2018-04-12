//
//  UIFont+CustomFont.m
//  Animation
//
//  Created by dfw on 2018/1/2.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+(UIFont *)systemFontOfSize:(CGFloat)fontSize
{
    return [self fontWithName:@"MicrosoftYaHei" size:fontSize];
}
#pragma clang diagnostic pop
@end
