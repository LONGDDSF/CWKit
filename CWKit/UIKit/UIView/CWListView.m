//
//  CWListView.m
//  CWKit
//
//  Created by syswin on 2018/1/22.
//

#import "CWListView.h"
#import "Masonry.h"

@interface CWListView ()

@property (strong, nonatomic) UIView *viewContainer;

@property (strong, nonatomic) NSMutableArray <UIView *>*itemsMArray;

@end

@implementation CWListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.countOfPerRow = kCWListViewCountOfRow;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemSizeW = self.viewContainer.frame.size.width / self.countOfPerRow;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat topSpace = 0 + idx / self.countOfPerRow * itemSizeW;
        CGFloat leftSpace = 0 + (idx % self.countOfPerRow) * itemSizeW;
        
        [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(topSpace);
            
            make.size.mas_equalTo(CGSizeMake(itemSizeW, itemSizeW));
            
            make.left.mas_equalTo(leftSpace);
        }];
        
        if (idx == self.subviews.count - 1) {
            
            [obj mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }
    }];
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
        
        [self addSubview:itemView];
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
