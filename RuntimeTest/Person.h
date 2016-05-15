//
//  Person.h
//  copyAndRetainTest
//
//  Created by change009 on 16/5/14.
//  Copyright © 2016年 change009. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Person类协议
 */
@protocol PersonDelegate <NSObject>

- (void) PersonDelegateToWork;

@end


@interface Person : NSObject

#pragma mark - 属性

@property (nonatomic,strong) NSString *name;    //姓名

@property (nonatomic,strong) NSString *sex;     //性别

@property (nonatomic,assign) NSInteger age;     //年龄


#pragma mark - 方法

- (void) eat;

- (void) work;

- (void) sleep;

@end
