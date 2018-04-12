//
//  PresentNextViewController.h
//  Animation
//
//  Created by dfw on 2017/10/31.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresentNextViewControllerDelegate <NSObject>

- (void) presentViewNextControllerDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionPresent;

@end

@interface PresentNextViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) id <PresentNextViewControllerDelegate> delegate;
@property (nonatomic, strong) RACSubject *delegateSingle;

@end
