//
//  TNListView.m
//  TNSearchVC
//
//  Created by syswin on 2017/10/30.
//  Copyright © 2017年 LONGDD. All rights reserved.
//

#import "TNListView.h"

#import "Masonry.h"

@interface TNListView ()

@end

@implementation TNListView

#pragma mark - ------------------ life cycle

#pragma mark - ------------------ public

+ (instancetype)listView
{
    TNListView *aview = [[self alloc] init];
    
    return aview;
}

- (void)updateWithConfig
{
    [self configCollectionViewWith:self.viewConfig];
    
    [self updateCollectionViewContraints];
}

#pragma mark - ------------------ collection view

- (void)configCollectionViewWith:(TNListViewConfig *)conifg
{
    [self.collectionView setCollectionViewLayout:conifg.collectionFLayout animated:NO];
    
    [self.collectionView registerClass:NSClassFromString(conifg.cellClassName) forCellWithReuseIdentifier:conifg.cellClassName];
}

- (void)updateCollectionViewContraints
{
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - ------------------ set / get

- (TNListViewConfig *)viewConfig
{
    if (!_viewConfig) {
        _viewConfig = [[TNListViewConfig alloc] init];
    }
    
    return _viewConfig;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.viewConfig.collectionFLayout];
        
        [self addSubview:_collectionView];
    }
    
    return _collectionView;
}

@end
