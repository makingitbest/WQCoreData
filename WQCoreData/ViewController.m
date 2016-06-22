//
//  ViewController.m
//  WQCoreData
//
//  Created by 王巧 on 16/4/13.
//  Copyright © 2016年 wangqiao. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>//5.导入文件

#import "Employee.h"//实体类
#import "Status.h"

@interface ViewController ()
{

    NSManagedObjectContext * _companycontext;
    NSManagedObjectContext * _weibocontext;

    NSManagedObjectContext * _context;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addbutton];
    
    _companycontext =[self setUpContextWithModelName:@"Company"];
    
    _weibocontext = [self setUpContextWithModelName:@"Weibo"];
    
//        _context = context;
   
}


-(NSManagedObjectContext*)setUpContextWithModelName:(NSString *)modelName{
    
    //1.创建模型文件
    //2.添加实体
    //3.创建实体类
    //4.生成上下文
    NSManagedObjectContext * context = [[NSManagedObjectContext alloc]init];
    
    
    //使用下面的方法.如果budles为空,就会把所有模型文件表放在一个数据库中
    //    NSManagedObjectModel * model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSLog(@"%@",[NSBundle mainBundle].bundlePath);
    
    
    //制定多个数据库
    NSURL * companyurl = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel * model = [[NSManagedObjectModel alloc]initWithContentsOfURL:companyurl];
    
    
    
    //5.持久化存储调度器
    NSPersistentStoreCoordinator * store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //文件需要保存到一个目录里面去,告诉coredata数据库的文件和路径
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *sqliteName = [NSString stringWithFormat:@"%@.sqlite",modelName];

    NSString * sqlitepath = [doc stringByAppendingPathComponent:sqliteName];
    
    NSLog(@"%@",sqlitepath);
    
    //这里传的URL 这么创建的 [NSURL fileURLWithPath:sqlitepath]
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitepath] options:nil error:nil];
    
    
    context.persistentStoreCoordinator = store;
    
    return context;



}

-(void)addbutton{

    UIButton * button0 =[[UIButton alloc]init];
    button0.backgroundColor = [UIColor greenColor];
    button0.frame = CGRectMake(20, 20, 100, 44);
    [button0 addTarget:self action:@selector(addEmployee) forControlEvents:UIControlEventTouchUpInside];
    [button0 setTitle:@"增加" forState:UIControlStateNormal];
    [self.view addSubview:button0];
    
    UIButton * button1 =[[UIButton alloc]init];
    button1.backgroundColor = [UIColor grayColor];
    button1.frame = CGRectMake(20, 70, 100, 44);
    [button1 addTarget:self action:@selector(readEmployee) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"读取" forState:UIControlStateNormal];
    [self.view addSubview:button1];

    
    UIButton * button2 =[[UIButton alloc]init];
    button2.backgroundColor = [UIColor redColor];
    button2.frame = CGRectMake(20, 120, 100, 44);
    [button2 addTarget:self action:@selector(deleteEmployee) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"删除" forState:UIControlStateNormal];
    [self.view addSubview:button2];

    
    UIButton * button3 =[[UIButton alloc]init];
    button3.backgroundColor = [UIColor orangeColor];
    button3.frame = CGRectMake(20, 170, 100, 44);
    [button3 addTarget:self action:@selector(updateEmployee) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"更新" forState:UIControlStateNormal];
    [self.view addSubview:button3];

}

#pragma mark ---addEmployee添加员工
-(void)addEmployee{
    //创建员工对象
        Employee * emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_companycontext];
        emp.height = @(160.0);
        emp.name = @"wangwu";
        emp.birthday= [NSDate date];
    [_companycontext save:nil];
    
    //直接保存到数据库中
    NSError * error = nil;
    [_companycontext save:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }

    //weibo
    Status * sta = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:_weibocontext];
    sta.createDate = [NSDate date];
    sta.text = @"我想工作";
    [_weibocontext save:nil];
    
    


}

#pragma mark --readEmployee读取员工
-(void)readEmployee{

//NSFetchRequest 抓取对象
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
        //执行请求
    NSError * error = nil;
    NSArray * emps = [_companycontext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    
    //遍历员工
    for (Employee * emp in emps) {
        NSLog(@"名字:%@  身高:%@ 生日:%@",emp.name ,emp.height,emp.birthday);
    }


}

#pragma mark - updateEmployee更新数据
-(void)updateEmployee{
   

}

#pragma mark - deleteEmployee
-(void)deleteEmployee{

   

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
