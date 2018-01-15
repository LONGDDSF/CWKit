//
//  UIView+TapGesture.h
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import <UIKit/UIKit.h>

@interface UIView (TapGesture)

- (UITapGestureRecognizer *)addTapGestureWithSel:(NSString *)selName target:(id)obj;

@end
