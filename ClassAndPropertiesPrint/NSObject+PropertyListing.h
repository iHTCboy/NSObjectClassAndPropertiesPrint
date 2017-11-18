//
//  NSObject+PropertyList.h
//  ClassAndPropertiesPrint
//
//  Created by HTC on 2017/11/18.
//  Copyright © 2017年 iHTCboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyList)

- (NSArray *)propertyNamesWithArray;

- (NSDictionary *)propertiesWithDictionary;

- (void)printClassAndProperties;

@end
