//
//  FFProxy.m
//  NSProxy的使用
//
//  Created by wangzhe on 2019/3/4.
//  Copyright © 2019年 MoGuJie. All rights reserved.
//

#import "FFProxy.h"
#import <objc/runtime.h>

@interface FFProxy ()
//方法字典 key:methodName value:target
@property(nonatomic,strong)NSMutableDictionary *methodDic;
//当前target
@property (nonatomic,strong) id target;

@end

@implementation FFProxy

-(NSMutableDictionary *)methodDic{
    if (!_methodDic) {
        _methodDic = [NSMutableDictionary dictionary];
    }
    return _methodDic;
}

-(void)proxyWithTargets:(NSArray*)targets{
    if (targets && targets.count) {
        [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self registMethodWithTarget:obj];
        }];
    }
}

#pragma mark private method
//methodDic字典赋值
-(void)registMethodWithTarget:(id)target{
    unsigned int countOfMethods = 0;
    //得到方法列表
    Method *method_list = class_copyMethodList([target class], &countOfMethods);
    for (int i = 0; i<countOfMethods; i++) {
        Method method = method_list[i];
        //得到方法的符号
        SEL sel = method_getName(method);
        //得到方法的符号字符串
        const char *sel_name = sel_getName(sel);
        //得到方法的名字
        NSString *method_name = [NSString stringWithUTF8String:sel_name];
        //字典赋值
        self.methodDic[method_name] = target;
    }
    free(method_list);
}

#pragma mark NSProxy方法
- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSString *methodName = NSStringFromSelector(sel);
    id target = self.methodDic[methodName];
    if (target && [target respondsToSelector:sel]) {
         return [target methodSignatureForSelector:sel];
    }else{
         return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    //获取当前选择子
    SEL sel = invocation.selector;
    //获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    //在字典中查找对应的target
    id target = self.methodDic[methodName];
    
    //检查target
    if (target && [target respondsToSelector:sel]) {
        
        //拦截测试
        if ([target isKindOfClass:[NSClassFromString(@"FFStudent") class]]
            && [methodName isEqualToString:@"stuTest:"]) {
            //拦截方法的执行者为复制的对象
            [invocation setTarget:target];
            //拦截参数 Argument:表示的是方法的参数  index:表示的是方法参数的下标
            NSString *str = @"FFProxy拦截";
            //截取第一个参数 如果是3说明是第二个参数；0 1 两个参数已经被target 和selector占用 所以index从2开始
            [invocation setArgument:&str atIndex:2];
            //开始调用方法
            [invocation invoke];
        }else{
            [invocation invokeWithTarget:target];
        }
    }else{
        [super forwardInvocation:invocation];
    }
}

@end
