//
//  Light.m
//  Animation
//
//  Created by Mr.L on 2018/12/12.
//  Copyright © 2018 东方网. All rights reserved.
//

#import "Light.h"

@implementation Light

-(instancetype)initWithName:(NSString *)name{
    self = [super  init];
    if (self) {
        self.name = name;
    }
    return self;
}
-(void)on{
    NSString * string = [NSString stringWithFormat:@"%@电灯开了",self.name];
    NSLog(string);
}
-(void)off{
    NSLog(@"电灯关了");
}

@end
