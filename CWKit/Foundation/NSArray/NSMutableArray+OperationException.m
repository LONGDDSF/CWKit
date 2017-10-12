//
//  NSMutableArray+OperationException.m
//  CWKit
//
//  Created by syswin on 2017/10/12.
//

#import "NSMutableArray+OperationException.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSMutableArray (OperationException)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
 
            [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(mutableObjectIndex:)];
            
            [objc_getClass("__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(mutableInsertObject:atIndex:)];
    
            [objc_getClass("__NSArrayM") swizzleMethod:@selector(addObject:) swizzledSelector:@selector(mutableAddObject:)];
            
            [objc_getClass("__NSArrayM") swizzleMethod:@selector(integerValue) swizzledSelector:@selector(replace_integerValue)];
        }
    });
}

- (id)mutableObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self mutableObjectIndex:index];
}

- (void)mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self mutableInsertObject:object atIndex:index];
    }
}

- (void)mutableAddObject:(id)obj
{
    if (obj) {
        
        [self mutableAddObject:obj];
    }
}

- (NSInteger)replace_integerValue {
    return 0;
}

@end
