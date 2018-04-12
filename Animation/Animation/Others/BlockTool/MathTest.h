//
//  MathTest.h
//  Animation
//
//  Created by dfw on 2017/11/17.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathTest : NSObject

@property (assign, nonatomic) BOOL isEqual;
@property (assign, nonatomic) int result;

- (MathTest *)calculate:(int (^)(int result))make;
- (MathTest *)equal :(BOOL (^)(int  result))operation;

@end
