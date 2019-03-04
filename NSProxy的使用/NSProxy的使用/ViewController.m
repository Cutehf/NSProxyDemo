//
//  ViewController.m
//  NSProxy的使用
//
//  Created by wangzhe on 2019/3/4.
//  Copyright © 2019年 MoGuJie. All rights reserved.
//

#import "ViewController.h"
#import "FFTeacher.h"
#import "FFStudent.h"
#import "FFProxy.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FFTeacher *teacher = [FFTeacher new];
    teacher.teacherName = @"王";
    
    FFStudent *student = [FFStudent new];
    student.stuName = @"钱";
    
    FFProxy *proxy = [FFProxy alloc];
    [proxy proxyWithTargets:@[teacher,student]];
    [proxy performSelector:@selector(sleep)];
    [proxy performSelector:@selector(study)];
    
    //测试拦截
    [proxy performSelector:@selector(stuTest:) withObject:@"导弹"];
    
    
    
}


@end
