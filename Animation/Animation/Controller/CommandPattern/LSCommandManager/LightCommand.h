//
//  LightCommand.h
//  Animation
//
//  Created by Mr.L on 2018/12/12.
//  Copyright © 2018 东方网. All rights reserved.
//

#import "BaseCommand.h"
@class Light;
NS_ASSUME_NONNULL_BEGIN

@interface LightCommand : BaseCommand


- (instancetype)initWith:(Light *)light;

@end

NS_ASSUME_NONNULL_END
