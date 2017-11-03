//
//  TNSelectItemCell.m
//  AFNetworking
//
//  Created by syswin on 2017/10/30.
//

#import "TNSelectItemCell.h"

#import "TNSelectItemCellModel.h"

#import "TNMessageView.h"

#import "Masonry.h"

@interface TNSelectItemCell ()

@property (strong, nonatomic) TNMessageView *messageView;

@property (strong, nonatomic) UIView *viewBottomLine;

@end

@implementation TNSelectItemCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
   
    if (self) {
        
        [self.contentView addSubview:self.messageView];
        
        [self updateLayoutMessageView];
        
        [self.contentView addSubview:self.viewBottomLine];
        [self updateLayoutBottomLine];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)loadCellWithModel:(id)obj
{
    if ([obj isKindOfClass:[TNSelectItemCellModel class]]) {
        
        TNSelectItemCellModel *model = (TNSelectItemCellModel *)obj;
        
        BOOL isH = YES;
        
        self.messageView.lblMsgDetail.text = model.title;
        
        self.messageView.imageViewLeft.image = model.image;
        
        self.messageView.msgCount = model.msgAlertCount;
        
        [self.messageView updateUI:isH];
    }
}

#pragma mark - ------------------ private

- (void)updateLayoutMessageView
{
    [self.messageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.top.mas_equalTo(0);
    }];
}

- (void)updateLayoutBottomLine
{
    [self.viewBottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - ------------------

- (TNMessageView *)messageView
{
    if (!_messageView) {
        
        _messageView = [[TNMessageView alloc] init];
    }
    
    return _messageView;
}

- (UIView *)viewBottomLine
{
    if (!_viewBottomLine) {
        
        _viewBottomLine = [[UIView alloc] init];
        
        [_viewBottomLine setBackgroundColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1]];
    }
    
    return _viewBottomLine;
}

@end
