//
//  CWButton.h
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import <UIKit/UIKit.h>

@interface CWButton : UIView

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *lblTitle;

@property (copy, nonatomic) void(^blockTapEvent)();

@end
