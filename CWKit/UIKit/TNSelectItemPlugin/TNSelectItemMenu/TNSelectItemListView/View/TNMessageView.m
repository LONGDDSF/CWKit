//
//  TNMessageView.m
//  AFNetworking
//
//  Created by syswin on 2017/11/2.
//

#import "TNMessageView.h"
#import "Masonry.h"

@interface TNMessageView ()

@property (strong, nonatomic) UIView *viewContainer;

@property (strong, nonatomic) UIImageView *imageViewLeft;

@property (strong, nonatomic) UILabel *lblMsgDetail;

@property (strong, nonatomic) UILabel *lblMsgCount;

@property (strong, nonatomic) UIImageView *imageViewRight;

@property (assign, nonatomic) CGFloat widthLblMsgCount;

@end

@implementation TNMessageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isHorizontal = YES;
        
        self.heightLblMsgCount = 15.f;
        
        [self addSubview:self.viewContainer];
        
        [self.viewContainer addSubview:self.imageViewLeft];
        
        [self.viewContainer addSubview:self.lblMsgDetail];
        
        [self.viewContainer addSubview:self.lblMsgCount];
        
        [self.viewContainer addSubview:self.imageViewRight];
        
        [self updateLayOutAll];
    }
    return self;
}

- (void)updateUI:(BOOL)isHorizontal
{
    {
        self.heightLblMsgCount = 15.f;
        
        NSString *msgCount = [NSString stringWithFormat:@"%ld",self.msgCount];
        
        if (self.msgCount == 0) {
            msgCount = nil;
            self.widthLblMsgCount = 0;
        }
        
        if (self.msgCount > 0 && self.msgCount < 10) {
            
            if (self.msgCount == 1) {
                
                msgCount = @"";
                
                self.heightLblMsgCount = 10.f;
            }
            
            self.widthLblMsgCount = self.heightLblMsgCount;
        }
        
        if (self.msgCount > 9) {
            
            self.widthLblMsgCount = 29;
            
            if (self.msgCount > 99) {
                msgCount = @"99+";
            }
        }
        
        self.lblMsgCount.text = msgCount;
        
        [self updateLayoutMsgCountLabel];
    }
    
    if (isHorizontal != self.isHorizontal) {
        
        self.isHorizontal = isHorizontal;
        
        [self updateLayOutAll];
    }
    
    [self setNeedsLayout];
}

- (void)updateLayOutAll
{
    if (self.isHorizontal) {
        
        [self.viewContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.top.mas_equalTo(0);
        }];
        
        [self.imageViewLeft mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(self.imageViewLeft.mas_height).multipliedBy(1).offset(0);
            make.height.mas_equalTo(50);
        }];
        
        [self.lblMsgDetail setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.lblMsgDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageViewLeft.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
        }];
        
        [self updateLayoutMsgCountLabel];
        
        [self.imageViewRight mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_greaterThanOrEqualTo(self.lblMsgCount.mas_right).offset(43);
            make.right.mas_equalTo(-17);
            make.centerY.mas_equalTo(0);
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.lblMsgCount.layer.cornerRadius = self.heightLblMsgCount / 2;
    
    self.lblMsgCount.layer.masksToBounds = YES;
}

- (void)updateLayoutMsgCountLabel
{
    [self.lblMsgCount mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblMsgDetail.mas_right).offset(8);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(self.heightLblMsgCount);
        make.width.mas_equalTo(self.widthLblMsgCount);
    }];
}

#pragma mark - ------------------ get

- (UIView *)viewContainer
{
    if (!_viewContainer) {
        
        _viewContainer = [[UIView alloc] init];
    }
    
    return _viewContainer;
}

- (UIImageView *)imageViewLeft
{
    if (!_imageViewLeft) {
        
        _imageViewLeft = [[UIImageView alloc] init];
    }
    
    return _imageViewLeft;
}

-(UILabel *)lblMsgCount
{
    if (!_lblMsgCount) {
        
        _lblMsgCount = [[UILabel alloc] init];
        
        _lblMsgCount.backgroundColor = [UIColor redColor];
        
        [_lblMsgCount setTextAlignment:NSTextAlignmentCenter];
        
        [_lblMsgCount setFont:[UIFont systemFontOfSize:9]];
        
        _lblMsgCount.textColor = [UIColor whiteColor];

    }
    
    return _lblMsgCount;
}

- (UILabel *)lblMsgDetail
{
    if (!_lblMsgDetail) {
        
        _lblMsgDetail = [[UILabel alloc] init];
        
        _lblMsgDetail.textColor = [UIColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1];
    }

    return _lblMsgDetail;
}

- (UIImageView *)imageViewRight
{
    if (!_imageViewRight) {
        
        _imageViewRight = [[UIImageView alloc] init];
    }
    
    return _imageViewRight;
}

@end
