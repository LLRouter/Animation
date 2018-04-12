//
//  RACNextViewController.h
//  Animation
//
//  Created by dfw on 2017/11/21.
//  Copyright © 2017年 东方网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RACViewController.h"

@interface RACNextViewController : UIViewController

@property (nonatomic ,strong)RACSubject *subject;
@property (nonatomic , strong)RACViewController *racVC;

@end

