//
//  BaseCommand.h
//  Animation
//
//  Created by Mr.L on 2018/12/12.
//  Copyright © 2018 东方网. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Command <NSObject>

- (void)excute;

@end

@interface BaseCommand : NSObject<Command>

@end

