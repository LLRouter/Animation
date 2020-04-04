//
//  Quartz2dView.m
//  Animation
//
//  Created by dfw on 2018/4/13.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "Quartz2dView.h"

@implementation Quartz2dView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.描述路径
    //2.1 创建路径
    CGPoint pionts[] = {{10, 100}, {40, 100}, {40, 200}};
    CGContextSetLineWidth(ctx, 2);
    CGFloat length[] = {5,10,5};
    CGContextSetLineDash(ctx, 5, length, 3);
    CGContextAddLines(ctx, pionts, 3);
    CGContextSetRGBStrokeColor(ctx, 0, 111, 188, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinMiter);
    CGContextSetShadowWithColor(ctx, CGSizeMake(2, 2), 0.3, UIColor.whiteColor.CGColor);
    //3.完成路线
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    CGFloat x = 100;
    CGFloat y = 100;
    CGFloat radius = 25;
    
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, radius, - M_PI_2, M_PI_2, NO);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    // 绘制多条线段
    CGPoint points[] = {{0, 200}, {30, 200}, {0, 300},{80, 300}};
    CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
    CGContextStrokeLineSegments(ctx, points, 4);
    CGContextStrokePath(ctx);
    
    
    CGFloat floatX = 200;
    CGFloat floatY = 200;
    CGPoint center = CGPointMake(floatX, floatY);
    CGFloat endA = 0;
    CGFloat startA = 0;
    CGFloat radiusA = 100;
    
    NSArray *nums = @[@23,@34,@33,@13,@30,@44,@66];

    NSInteger total = 0;
    for (id num in nums) {
        total += [num integerValue];
    }
    
    for (int i = 0; i < 7; i++) {
         id num = nums[i];
         startA = endA;
         endA = startA + [num floatValue] / total * 2 * M_PI;
         UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:center radius:radiusA startAngle:startA endAngle:endA clockwise:YES];
        [circle addLineToPoint:center];
    
        [[self randomColor] set];
        
        [circle fill];
    }
    
    CGFloat margin = 30;
    CGFloat width = (rect.size.width - (7 + 1)*margin)/7;
    for (int i = 0; i < 7; i++) {
        
        CGFloat x = margin + (width + margin)*i;
        CGFloat num = [nums[i] floatValue]/100;
        CGFloat y = rect.size.height * (1-num);
        CGFloat height = rect.size.height*num;
        
        CGRect rectA =  CGRectMake(x, y, width, height);
        CGContextAddRect(ctx,rectA);
        [[self randomColor] set];
        CGContextFillPath(ctx);
    }
    
}
- (UIColor *)randomColor
{
    CGFloat randRed = arc4random_uniform(256)/255.0;
    CGFloat randGreen = arc4random_uniform(256)/255.0;
    CGFloat randBlue = arc4random_uniform(256)/255.0;
    
    UIColor *randomColor = [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1.0];
    return randomColor;
}

@end
