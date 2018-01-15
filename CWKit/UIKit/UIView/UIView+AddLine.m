//
//  UIView+AddLine.m
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import "UIView+AddLine.h"
#import <objc/runtime.h>
#import "Masonry.h"

@implementation UIView (AddLine)

@dynamic aLine;

static char keyRuntimeSetAline;

- (void)setALine:(UIView *)aLine
{
    objc_setAssociatedObject(self, &keyRuntimeSetAline, aLine, OBJC_ASSOCIATION_RETAIN);
}

-(UIView *)aLine
{
    UIView *view = objc_getAssociatedObject(self, &keyRuntimeSetAline);
    
    if (!view || ![view isKindOfClass:[UIView class]]) {
        
        view = [[UIView alloc] init];
        
        view.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
        
        self.aLine = view;
    }
    
    return view;
}

- (void)showBottomLineWithLayout:(CWLineLayout)layout
{
    if (!self.aLine.superview) {
        [self addSubview:self.aLine];
    }
    
    [self.aLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(layout.left);
        make.right.mas_equalTo(layout.right);
        make.height.mas_equalTo(layout.height);
        make.bottom.mas_equalTo(0);
    }];
}

@end

