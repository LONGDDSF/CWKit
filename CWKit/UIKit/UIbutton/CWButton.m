//
//  CWButton.m
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import "CWButton.h"
#import "Masonry.h"

#import "UIView+TapGesture.h"

@implementation CWButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addViews];

        [self addTapGestureWithSel:@"tapEventHandle" target:self];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)addViews
{
    [self addSubview:self.imageView];
    
    [self addSubview:self.lblTitle];
    
    [self updateLayoutImageview];
    [self updateLayoutTitle];
}

#pragma mark -- --------- gesture

- (void)tapEventHandle
{
    if (self.blockTapEvent) {
        self.blockTapEvent();
    }
}


#pragma mark -- --------- image view

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

- (void)updateLayoutImageview
{
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark -- --------- lbl title

-(UILabel *)lblTitle
{
    if (!_lblTitle) {
        
        _lblTitle = [[UILabel alloc] init];
    }
    
    return _lblTitle;
}

- (void)updateLayoutTitle
{
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_greaterThanOrEqualTo(self.imageView.mas_bottom).offset(10);;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
