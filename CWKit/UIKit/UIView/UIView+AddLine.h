//
//  UIView+AddLine.h
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import <UIKit/UIKit.h>

typedef struct CWLineLayout {
    CGFloat left, right, height;
} CWLineLayout;

@interface UIView (AddLine)

@property (assign, nonatomic) UIView *aLine;

- (void)showBottomLineWithLayout:(CWLineLayout)layout;

@end
