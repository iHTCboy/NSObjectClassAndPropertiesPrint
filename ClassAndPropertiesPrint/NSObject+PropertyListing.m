//
//  NSObject+PropertyList.m
//  ClassAndPropertiesPrint
//
//  Created by HTC on 2017/11/18.
//  Copyright © 2017年 iHTCboy. All rights reserved.
//

#import "NSObject+PropertyListing.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (PropertyList)


/**
 获取对象的所有属性，不包括属性值

 @return 当前类的所有属性名数组
 */
- (NSArray *)propertyNamesWithArray {
    
    u_int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    // 遍历
    for (int i = 0; i<count; i++)
    {
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char* propertyName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [propertiesArray addObject:name];
    }
    free(properties);
    return propertiesArray.copy;
}


/**
 获取对象的所有属性 以及属性值

 @return 当前类的所有属性键值对
 */
- (NSDictionary *)propertiesWithDictionary {
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    u_int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return props;
}


/**
 获取对象的所有方法
 */
- (void)printClassAndProperties {
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
//        IMP imp_f = method_getImplementation(temp_f);
//        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@, 参数个数：%d, 编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

@end
