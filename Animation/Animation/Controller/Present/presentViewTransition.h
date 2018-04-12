//
//  presentViewTransition.h
//  Animation
//
//  Created by dfw on 2017/11/1.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,PresentTransitionType){
    PresentTransitionTypePresent = 0,
    PresentTransitionTypeDismiss
};

@interface PresentViewTransition : NSObject<UIViewControllerAnimatedTransitioning>

+(instancetype)transitionWithType:(PresentTransitionType)type;
-(instancetype) initWithTransitionType:(PresentTransitionType)type;

@end
