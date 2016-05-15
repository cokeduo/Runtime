//
//  ViewController.m
//  RuntimeTest
//
//  Created by change009 on 16/5/15.
//  Copyright © 2016年 change009. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()<PersonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self deCode];
    
}

/**
 *  获取一个类的全部成员变量
 */
- (void) getObjcAllIvars{
    
    unsigned int count = 0;
    
    //获取成员变量的结构体
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        //获取成员变量的名称，获取到的都为C字符串
        const char *name = ivar_getName(ivars[i]);
        
        //C字符串专为OC字符串
        NSString *OC_name = [NSString stringWithUTF8String:name];
        
        NSLog(@"i:%d ---- name:%@",i,OC_name);
        
    }
    
    //因为ivars不属于OC对象，所以要记得释放
    free(ivars);
}




/**
 *  获取一个类的全部属性名称
 */
- (void) getObjcAllProperties{
    
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        //获取属性名称（C字符串）
        const char *name = property_getName(properties[i]);
        
        NSString *OC_name = [NSString stringWithUTF8String:name];
        
        NSLog(@"i:%d --- propertyName:%@",i,OC_name);
        
    }
    
    //非OC对象，记得释放
    free(properties);
    
}


/**
 *  获取一个类的全部方法
 */
- (void) getObjcAllMethod{
    
    unsigned int count = 0;
    
    //获取指向改类所有方法的指针
    Method *methods = class_copyMethodList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        //获取方法
        SEL method = method_getName(methods[i]);
        
        //获取方法名字（C字符串）
        const char *name = sel_getName(method);
        
        NSString *methodName = [NSString stringWithUTF8String:name];
        
        //获取方法参数个数
        int arguments = method_getNumberOfArguments(methods[i]);
        
        NSLog(@"i:%d ---- methodName:%@ --- arguments:%d",i,methodName,arguments);
    }
    //释放
    free(methods);
}


/**
 *  获取一个类遵循的全部协议
 */
- (void) getObjcAllProtocol{
    
    unsigned int count = 0;
    
    //获取指向改类遵循的所有协议的指针
    __unsafe_unretained Protocol **protocols = class_copyProtocolList([self class], &count);
    
    for (int i = 0 ; i < count; i++) {
        
        //获取改类遵循的一个协议指针
        Protocol *protocol = protocols[i];
        
        //获取C字符串协议名字
        const char *name = protocol_getName(protocol);
        
        NSString *OCProtocolName =[NSString stringWithUTF8String:name];
        
        NSLog(@"i:%d --- protocolName:%@",i ,OCProtocolName);
    }
    
    //释放
    free(protocols);
    
}

/**
 *  归档／解档
 */
- (void) deCode{
    
    Person *person = [[Person alloc] init];
    
    person.name = @"王五";
    person.sex = @"男";
    person.age = 20;
    
    NSString *path = [NSString stringWithFormat:@"%@/archive",NSHomeDirectory()];
    
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
    Person *unarchivePerson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"unarchivePerson:%@",unarchivePerson);
    
}


@end
