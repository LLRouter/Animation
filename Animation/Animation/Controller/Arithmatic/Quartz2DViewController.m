//
//  Quartz2DViewController.m
//  Animation
//
//  Created by dfw on 2018/4/13.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "Quartz2DViewController.h"
#import "Quartz2dView.h"

@interface Quartz2DViewController ()

@end

@implementation Quartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    Quartz2dView *quartz = [[Quartz2dView alloc] init];
    quartz.frame = self.view.frame;
    [self.view addSubview:quartz];
}

@end
