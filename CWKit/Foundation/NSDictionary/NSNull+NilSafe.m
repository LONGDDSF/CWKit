//
//  NSNull+NilSafe.m
//  CWKit
//
//  Created by syswin on 2017/10/17.
//

#import "NSNull+NilSafe.h"
#import "NSObject+Swizzling.h"

@implementation NSNull (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(methodSignatureForSelector:) swizzledSelector:@selector(gl_methodSignatureForSelector:)];
        [self swizzleMethod:@selector(forwardInvocation:) swizzledSelector:@selector(gl_forwardInvocation:)];
    });
}

- (NSMethodSignature *)gl_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self gl_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)gl_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }
    
    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}

@end
