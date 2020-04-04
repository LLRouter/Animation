//
//  circleProgress.m
//  Animation
//
//  Created by Mr.L on 2018/9/25.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "circleProgress.h"

@implementation circleProgress

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(40, 40, 30, 30));
    CGContextDrawPath(context, kCGPathEOFill);
    
    CGContextMoveToPoint(context, 40, 40);
    
}



@end
