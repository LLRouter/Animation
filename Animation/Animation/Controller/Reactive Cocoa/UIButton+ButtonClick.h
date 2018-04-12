//
//  UIButton+ButtonClick.h
//  Animation
//
//  Created by dfw on 2017/12/7.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(void);

@interface UIButton (ButtonClick)

@property (nonatomic, copy) buttonClick click;

@end
