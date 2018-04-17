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
#import "StudentClass+CoreDataClass.h"

#define  MainApplication ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface ArithmeticViewController ()

@property(nonatomic)UITextField * predicate;

@end

@implementation ArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view from its nib.
    [self testMaoPao];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(20, 100, 100, 40);
//    [btn setTitle:@"read" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor greenColor];
//    btn.click = ^{
//        [self doRead];
//    };
//    [self.view addSubview:btn];
    
    _predicate = [[UITextField alloc] init];
    _predicate.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:_predicate];
    [_predicate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(160);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
    }];
  
    
    UIButton *btnPredicate = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPredicate.frame = CGRectMake(20, 100, 100, 40);
    [btnPredicate setTitle:@"条件读取" forState:UIControlStateNormal];
    btnPredicate.backgroundColor = [UIColor greenColor];
    __weak typeof(self) weak = self;
    btnPredicate.click = ^{
        [weak doRead];
    };
    [self.view addSubview:btnPredicate];
    
    UIButton *btnClass = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClass.frame = CGRectMake(20, 200, 100, 40);
    [btnClass setTitle:@"条件读取Class" forState:UIControlStateNormal];
    btnClass.backgroundColor = [UIColor greenColor];
    btnClass.click = ^{
        [weak doReadClass];
    };
    [self.view addSubview:btnClass];
    
    
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
    
    StudentClass *class = [NSEntityDescription insertNewObjectForEntityForName:@"StudentClass" inManagedObjectContext:delegate.persistentContainer.viewContext];
    class.classId = @5;
    class.name = @"九年级";
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:delegate.persistentContainer.viewContext];
    student.studentId = @1;
    student.studentAge = @20;
    student.studentName = @"Mr.L";
    student.relationship = class;
   
    [class addRelationshipObject:student]; //如果不想加这句可以在coredata 模型里面的relationship设置双向关联（inverse）
    
    [delegate saveContext];
}
- (void)doReadClass
{
    //    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
    //    NSFetchRequest *fetch = [NSFetchRequest  new];
    NSManagedObjectContext *context = MainApplication.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentClass" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"wangwu1"];//查询姓名以wangwu1开头的员工
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@",@"1"];//查询姓名以1结尾的员工
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"wu13"];//查询姓名中包含wu13的员工
    // NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"*wu13"];//查询姓名以wu13结尾的员工，＊wu13中的＊是通配符，如果写成wu13*则表示名字以wu13开头的员工
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", _predicate.text];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSError *error = nil;
    NSArray *fetchedObjects = [MainApplication.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }else{
        for (StudentClass *s  in fetchedObjects) {
            NSLog(@"%@...%@.",s.name,s.classId);
            
            [MainApplication.persistentContainer.viewContext deleteObject:s];
            [MainApplication saveContext];
            //
            //            s.studentAge = 40;
            //            [context updatedObjects];
            //            [MainApplication saveContext];
        }
    }
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
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"wangwu1"];//查询姓名以wangwu1开头的员工
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@",@"1"];//查询姓名以1结尾的员工
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"wu13"];//查询姓名中包含wu13的员工
    // NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"*wu13"];//查询姓名以wu13结尾的员工，＊wu13中的＊是通配符，如果写成wu13*则表示名字以wu13开头的员工
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"studentName CONTAINS %@", _predicate.text];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSError *error = nil;
    NSArray *fetchedObjects = [MainApplication.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        
    }else{
        for (Student *s  in fetchedObjects) {
            NSLog(@"%@...%@..%@..%@",s.studentName,s.studentAge,s.studentId,s.relationship.name);
           
            [MainApplication.persistentContainer.viewContext deleteObject:s];
            [MainApplication saveContext];
//
//            s.studentAge = 40;
//            [context updatedObjects];
//            [MainApplication saveContext];
        }
    }
}
// 多表关联的删除
//1.3.3-Nullify（为空）
//如果设置教室相对于学生的删除关联为Nullify，则表示：如果删除教室，学生并不会删除，只是学生的教室为null
//1.3.4-Cascade（级联）
//如果设置教室相对于学生的删除关联为Cascade，则表示：如果删除学生，则学生对应的教室也会被删除
//1.3.5-Deny（拒绝）
//如果设置教室相对于学生的删除关联为Deny，则表示：只要教室存在，就无法删除学生，要想删除学生，就要先删除教室
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
