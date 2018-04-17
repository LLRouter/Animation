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
#import "AppDelegate.h"
#import "Student+CoreDataClass.h"
#import "Student+CoreDataProperties.h"

#define  MainApplication ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface ArithmeticViewController ()

@end

@implementation ArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view from its nib.
    [self testMaoPao];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, 100, 40);
    [btn setTitle:@"read" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    btn.click = ^{
        [self doRead];
    };
    [self.view addSubview:btn];
    
    
    if (@available(iOS 11.0,*)){
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
        
        UIImage *image = [[UIImage imageNamed:@"navigation_back_pressed"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0,image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, -10) forBarMetrics:UIBarMetricsDefault];
        
        UIImage *backButtonImage = [[UIImage imageNamed:@"navigation_back_pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [UINavigationBar appearance].backIndicatorImage = backButtonImage;
        
        [UINavigationBar appearance].backIndicatorTransitionMaskImage =backButtonImage;
    }
    [self doTest];
}
- (void)doTest
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:delegate.persistentContainer.viewContext];
    student.studentId = 1;
    student.studentAge = 20;
    student.studentName = @"Mr.L";
    [delegate saveContext];
}
- (void)doRead
{
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
//    NSFetchRequest *fetch = [NSFetchRequest  new];
    NSManagedObjectContext *context = MainApplication.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"studentName CONTAINS %@", @"Mr.L"];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSError *error = nil;
    NSArray *fetchedObjects = [MainApplication.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }else{
        for (Student *s  in fetchedObjects) {
            NSLog(@"%@...%d..%d",s.studentName,s.studentAge,s.studentId);
            [MainApplication.persistentContainer.viewContext deleteObject:s];
            [MainApplication saveContext];
//
//            s.studentAge = 40;
//            [context updatedObjects];
//            [MainApplication saveContext];
        }
    }
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
