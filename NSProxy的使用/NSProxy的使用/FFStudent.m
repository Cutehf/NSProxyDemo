//
//  FFStudent.m
//  NSProxy的使用
//
//  Created by wangzhe on 2019/3/4.
//  Copyright © 2019年 MoGuJie. All rights reserved.
//

#import "FFStudent.h"

@implementation FFStudent

-(void)study{
    NSLog(@"%@同学在学习。。。",self.stuName);
}

-(void)stuTest:(NSString *)intercept{
    NSLog(@"拦截到了消息:%@",intercept);
}

@end
