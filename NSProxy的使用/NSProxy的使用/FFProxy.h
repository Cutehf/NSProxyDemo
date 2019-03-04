//
//  FFProxy.h
//  NSProxy的使用
//
//  Created by wangzhe on 2019/3/4.
//  Copyright © 2019年 MoGuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFProxy : NSProxy

-(void)proxyWithTargets:(NSArray*)targets;

@end

NS_ASSUME_NONNULL_END
