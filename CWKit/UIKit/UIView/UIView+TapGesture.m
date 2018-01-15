//
//  UIView+TapGesture.m
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import "UIView+TapGesture.h"

@implementation UIView (TapGesture)

- (UITapGestureRecognizer *)addTapGestureWithSel:(NSString *)selName target:(id)obj
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self addGestureRecognizer:tap];
    
    SEL asel = NSSelectorFromString(selName);
    
    if ([obj respondsToSelector:asel]) {
        [tap addTarget:obj action:asel];
    }
    
    return tap;
}
@end
