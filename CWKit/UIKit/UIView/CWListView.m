//
//  CWListView.m
//  CWKit
//
//  Created by syswin on 2018/1/22.
//

#import "CWListView.h"
#import "Masonry.h"

static const CGFloat  kCWListViewItemSpaceV = 5.0;
static const CGFloat  kCWListViewItemSpaceH = 5.0;

@interface CWListView ()

@property (strong, nonatomic) UIView *viewContainer;

@property (strong, nonatomic) NSMutableArray <UIView *>*itemsMArray;

//item之间的间距，水平、竖直（）
@property (assign, nonatomic) CGFloat itemSpaceH;
@property (assign, nonatomic) CGFloat itemSpaceV;

@end

@implementation CWListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self resetConfig];
        
        [self addSubview:self.viewContainer];
        [self setCEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemSizeW = (self.viewContainer.frame.size.width) / self.countOfPerRow;
    
    NSArray *subviewsArr = self.viewContainer.subviews;
    
    [subviewsArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat topSpace = 0 + idx / self.countOfPerRow * (itemSizeW + self.itemSpaceV);
        CGFloat leftSpace = 0 + (idx % self.countOfPerRow) * (itemSizeW + self.itemSpaceH);
        
        [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(topSpace + self.itemEdgeInsets.top);
            
            make.size.mas_equalTo(CGSizeMake(itemSizeW - self.itemEdgeInsets.left - self.itemEdgeInsets.right, itemSizeW - self.itemEdgeInsets.top - self.itemEdgeInsets.bottom));
            
            make.left.mas_equalTo(leftSpace + self.itemEdgeInsets.left);
        }];
        
        if (idx == subviewsArr.count - 1) {
            
            [obj mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
        }
    }];
}

- (void)resetConfig
{
    self.countOfPerRow = kCWListViewCountOfRow;
    self.itemSpaceH = 0;
    self.itemSpaceV = 0;
    self.itemEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - ------------------ <#title#>

- (void)reloadDataWithTotleCount:(NSInteger)count itemConfig:(BlockListItemConfig)blockConfig
{
    [self.viewContainer.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        [obj removeFromSuperview];
    }];
    
    for (NSInteger idx = 0; idx < count; idx ++) {
        
        UIView *itemView = [[UIView alloc] init];
        
        if (blockConfig) {
            
            blockConfig(itemView, idx);
        }
        
        [self.viewContainer addSubview:itemView];
    }
}

#pragma mark - ------------------ container

- (UIView *)viewContainer
{
    if (!_viewContainer) {
        
        _viewContainer = [[UIView alloc] init];
    }
    
    return _viewContainer;
}

- (void)updateLayoutViewContainer
{
    [self.viewContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.cEdgeInsets);
    }];
}

- (void)setCEdgeInsets:(UIEdgeInsets)cEdgeInsets
{
    _cEdgeInsets = cEdgeInsets;
    
    [self updateLayoutViewContainer];
}


@end
