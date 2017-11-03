//
//  TNMessageView.h
//  AFNetworking
//
//  Created by syswin on 2017/11/2.
//

#import <UIKit/UIKit.h>

@interface TNMessageView : UIView

@property (assign, nonatomic) BOOL isHorizontal;

@property (strong, nonatomic, readonly) UIImageView *imageViewLeft;

@property (strong, nonatomic, readonly) UILabel *lblMsgDetail;

@property (strong, nonatomic, readonly) UIImageView *imageViewRight;

@property (assign, nonatomic) NSInteger msgCount;

@property (assign, nonatomic) CGFloat heightLblMsgCount;

- (void)updateUI:(BOOL)isHorizontal;

@end
