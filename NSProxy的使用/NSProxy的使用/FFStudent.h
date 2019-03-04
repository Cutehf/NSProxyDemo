//
//  FFStudent.h
//  NSProxy的使用
//
//  Created by wangzhe on 2019/3/4.
//  Copyright © 2019年 MoGuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFStudent : NSObject

@property (nonatomic,copy) NSString *stuName;

/**测试拦截，参数将会被拦截到*/
-(void)stuTest:(NSString*)intercept;

@end

NS_ASSUME_NONNULL_END
