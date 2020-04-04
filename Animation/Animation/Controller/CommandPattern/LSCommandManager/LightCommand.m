//
//  LightCommand.m
//  Animation
//
//  Created by Mr.L on 2018/12/12.
//  Copyright © 2018 东方网. All rights reserved.
//

#import "LightCommand.h"
#import "Light.h"

@interface LightCommand ()

/**  */
@property(nonatomic, strong)Light *light;

@end
@implementation LightCommand

-(instancetype)initWith:(Light *)light{
    self = [super init];
    if (self) {
        self.light = light;
    }
    return self;
}
- (void)excute{
  //  [super excute];
    [self.light on];
}
@end
