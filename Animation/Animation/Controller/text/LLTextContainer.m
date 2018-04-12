//
//  LLTextContainer.m
//  Animation
//
//  Created by dfw on 2017/11/16.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import "LLTextContainer.h"

@implementation LLTextContainer
- (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(CGRect *)remainingRect
{
    CGRect rect = [super lineFragmentRectForProposedRect:proposedRect atIndex:characterIndex writingDirection:baseWritingDirection remainingRect:remainingRect];
    CGSize  size = [self size];
    CGFloat radius = fmin(size.width, size.height) / 2.0f;
    CGFloat ypos = fabs((proposedRect.origin.y + proposedRect.size.height/ 2) - radius);
    CGFloat width = (ypos < radius) ? 2.0 * sqrt(radius * radius - ypos * ypos) : 0.0;
    CGRect circleRect = CGRectMake(radius - width / 2.0, proposedRect.origin.y, width, proposedRect.size.height);
    
    return CGRectIntersection(rect, circleRect);
}
@end
