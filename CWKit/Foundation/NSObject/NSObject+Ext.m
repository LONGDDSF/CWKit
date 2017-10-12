//
//  NSObject+Ext.m
//  funlive
//
//  Created by l.t.zero on 16/5/11.
//  Copyright © 2016年 renzhen. All rights reserved.
//

#import "NSObject+Ext.h"
#import <objc/runtime.h>

@implementation NSObject(ObjectExt)

@dynamic storageObject;

- (id)storageObject{
    return objc_getAssociatedObject(self, "storageObject");
}
- (void)setStorageObject:(id)storageObject{
    objc_setAssociatedObject(self, "storageObject", storageObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

@implementation NSObject(NumberCheck)



@end
