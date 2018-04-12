//
//  ArithmeticViewController.m
//  Animation
//
//  Created by dfw on 2018/1/23.
//  Copyright © 2018年 东方网. All rights reserved.
//

#import "ArithmeticViewController.h"
#import "Masonry.h"
#import "UIButton+ButtonClick.h"

@interface ArithmeticViewController ()

@end

@implementation ArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self testMaoPao];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.click = ^{
        NSLog(@"1111");
    };
}
- (void)testMaoPao
{
    NSHashTable *table = [NSHashTable  hashTableWithOptions:NSHashTableWeakMemory];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@13,@15,@7,@9,@10]];
    for (int i = 0; i < array.count -1; i++) {
        for (int j = 0; j < array.count - i -1; j++) {
            if (array[j] < array[j + 1]) {
//                id tmp = array[j];
//                array[j] = array[j + 1];
//                array[j + 1] = tmp;
                [array exchangeObjectAtIndex:j  withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@",array);
}
// 选择
-(void)function
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"5",@"3",@"6",@"2",@"1",@"7",@"4",nil];
    for (int i = 0; i < arr.count; i ++)
    {
        for (int j = i + 1; j < arr.count; j ++)
        {
            NSLog(@"当前对比的两个数是%@,%@",arr[i],arr[j]);
            if ([arr[i] intValue] > [arr[j] intValue])
            {
                NSString *temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
            NSLog(@"排序结果%@",arr);
        }
    }
    NSLog(@"选择排序完成后,数组内容为：%@",arr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
