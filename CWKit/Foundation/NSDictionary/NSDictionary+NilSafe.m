//
//  NSDictionary+NilSafe.m
//  NSDictionary-NilSafe
//
//  Created by Allen Hsu on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import "NSDictionary+NilSafe.h"

#import "NSObject+Swizzling.h"

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleMethod:@selector(initWithObjects:forKeys:count:) swizzledSelector:@selector(gl_initWithObjects:forKeys:count:)];
        
        [self swizzleMethod:@selector(dictionaryWithObjects:forKeys:count:) swizzledSelector:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class swizzleMethod:@selector(setObject:forKey:) swizzledSelector:@selector(gl_setObject:forKey:)];
        [class swizzleMethod:@selector(setObject:forKeyedSubscript:) swizzledSelector:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (anObject && aKey) {
        
        [self gl_setObject:anObject forKey:aKey];
    }
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    
    if (obj && key) {
        
        [self gl_setObject:obj forKeyedSubscript:key];
    }
}

@end
