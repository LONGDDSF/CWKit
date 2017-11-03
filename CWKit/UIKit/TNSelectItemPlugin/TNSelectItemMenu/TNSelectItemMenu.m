//
//  TNSelectItemMenu.m
//  AFNetworking
//
//  Created by syswin on 2017/10/30.
//

#import "TNSelectItemMenu.h"
#import "Masonry.h"


@interface TNSelectItemMenu ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *LblMsgAlert;

@property (strong, nonatomic) UIView *containerBcgView;

@property (strong, nonatomic) TNSelectItemCellModel *currentSelectItem;

@property (assign, nonatomic) CGFloat topSpaceOfMenuContainer;

@property (assign, nonatomic) BOOL hasShow;

@property (assign, nonatomic) BOOL isAnimating;

@end

@implementation TNSelectItemMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.LblMsgAlert];
        [self addSubview:self.imageView];
        [self updateLayoutImageView];
        [self updateLaytouLblMsgAlert];
        
        [self addGestureTapToSelf];
        [self addGestureTapToBcg];
    }
    
    return self;
}

- (void)reqDataAndReload
{
    __weak typeof(self) wSelf = self;
    [self.animateShowView.tnInteractor setBlockDidGetAllData:^(BOOL success) {
        
        [wSelf exchangeCurrentSelectItem:wSelf.animateShowView.tnInteractor.currentSelectModel];
    }];
}

- (void)didSelectedItem:(id)obj
{
    if ([obj isKindOfClass:[TNSelectItemCellModel class]]) {
        
        [self exchangeCurrentSelectItem:obj];
    }
}

- (void)exchangeCurrentSelectItem:(TNSelectItemCellModel *)modelNew
{
    self.currentSelectItem.isSelected = NO;
    
    modelNew.isSelected = YES;
    
    [self updateMenuWithModel:modelNew];
    
    [self.animateShowView.tnInteractor exchangeCurrentSelectItem:modelNew];
}

#pragma mark - ------------------ menu

- (void)updateMenuWithModel:(TNSelectItemCellModel *)model
{
    if (model.isSelected) {
        
        self.imageView.image = model.image;
        
        self.LblMsgAlert.hidden = (model.msgAlertCount > 0);
    }
}

#pragma mark - ------------------ aniamte show

- (void)showMenuContainer:(BOOL)animate
{
    if (!self.menuContainerView) {
        
        self.menuContainerView = [UIApplication sharedApplication].keyWindow;
    }
    
    self.containerBcgView.hidden = NO;
    
    [self.animateShowView layoutIfNeeded];
    
    self.isAnimating = YES;
    
    [UIView animateWithDuration:0 animations:^{
        
        [self updateLayoutAnimateView:0];
        self.animateShowView.alpha = 1;
        
        [self.containerBcgView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.hasShow = YES;
        self.isAnimating = NO;
    }];
}

- (void)hideMenuContainer:(BOOL)animate
{
    if (!self.menuContainerView) {
        
        self.menuContainerView = [UIApplication sharedApplication].keyWindow;
    }
    
    self.containerBcgView.hidden = YES;

    [self.animateShowView layoutIfNeeded];
    
    self.isAnimating = YES;
    
    [UIView animateWithDuration:0 animations:^{
        
        [self updateLayoutAnimateView:0];
        self.animateShowView.alpha = 0;
        
        [self.containerBcgView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
       
        self.hasShow = NO;
        self.isAnimating = NO;
    }];
}

#pragma mark - ------------------  gesture

- (void)addGestureTapToBcg
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEventTap)];
    
    [self.containerBcgView addGestureRecognizer:tap];
}

- (void)handleEventTap
{
   [self hideMenuContainer:YES];
}

- (void)addGestureTapToSelf
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEventTapSelf)];
    
    [self addGestureRecognizer:tap];
}

- (void)handleEventTapSelf
{
    if (self.isAnimating) {
        
        return;
    }
    
    if (self.hasShow) {
        
        [self hideMenuContainer:YES];
        
    }else{
        
        [self showMenuContainer:YES];
    }
}

#pragma mark - ------------------ private


- (void)updateLayoutImageView
{
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.top.mas_equalTo(0);
    }];
}

- (void)updateLaytouLblMsgAlert
{
    [self.LblMsgAlert mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.mas_equalTo(0);
        
        make.width.height.mas_equalTo(8);
    }];
}

- (void)updateLaytouMenuContainerBcg
{
    CGFloat topSpace = 0;
    
    CGPoint p = CGPointMake(self.center.x, self.center.y + self.frame.size.height / 2);
    
    CGPoint pointNew = [self.superview convertPoint:p toView:self.menuContainerView];
    
    topSpace = pointNew.y;
    
    if (self.containerBcgView.superview) {
     
        [self.containerBcgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(topSpace);
        }];
    }
}

- (void)updateLayoutAnimateView:(CGFloat)topSpace
{
    if (self.animateShowView.superview) {
     
        [self.animateShowView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.mas_equalTo(0);
            
            make.top.mas_equalTo(topSpace);
        }];
    }
}

#pragma mark - ------------------ super

//overide
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.LblMsgAlert.layer.cornerRadius = self.LblMsgAlert.bounds.size.width / 2;
    self.LblMsgAlert.layer.masksToBounds = YES;
}


#pragma mark - ------------------  get / set

- (UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

- (UILabel *)LblMsgAlert
{
    if (!_LblMsgAlert) {
        
        _LblMsgAlert = [[UILabel alloc] init];
        
        [_LblMsgAlert setTextColor:[UIColor whiteColor]];
        
        [_LblMsgAlert setBackgroundColor:[UIColor redColor]];
    }
    
    return _LblMsgAlert;
}

- (TNSelectItemListView *)animateShowView
{
    if (!_animateShowView) {
        
        _animateShowView = [TNSelectItemListView listView];
        
        __weak typeof(self) wSelf = self;
        [_animateShowView setBlockDidSelectedModel:^(TNSelectItemCellModel *model) {
            
            [wSelf didSelectedItem:model];
        }];
        
        [self.containerBcgView addSubview:_animateShowView];
        
        [self hideMenuContainer:NO];
    }
    
    return _animateShowView;
}

- (void)setMenuContainerView:(UIView *)menuContainerView
{
    if (_menuContainerView != menuContainerView) {
        
        _menuContainerView = menuContainerView;
        
        [self.containerBcgView removeFromSuperview];
        
        [_menuContainerView addSubview:self.containerBcgView];
        [self updateLaytouMenuContainerBcg];
    }
}

- (UIView *)containerBcgView
{
    if (!_containerBcgView) {
        
        _containerBcgView = [[UIView alloc] init];
        
        UIColor *color = [UIColor blackColor];
        _containerBcgView.backgroundColor = [color colorWithAlphaComponent:0.5];
    }
    
    return _containerBcgView;
}

- (TNSelectItemCellModel *)currentSelectItem
{
    if (!_currentSelectItem) {
        
        _currentSelectItem = self.animateShowView.tnInteractor.currentSelectModel;
    }
    
    return _currentSelectItem;
}

@end
