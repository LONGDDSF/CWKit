//
//  TNListViewModel.m
//  TNSearchVC
//
//  Created by syswin on 2017/10/30.
//  Copyright © 2017年 LONGDD. All rights reserved.
//

#import "TNListViewConfig.h"

@implementation TNListViewConfig

- (NSString *)cellClassName
{
    if (!_cellClassName) {
        
        _cellClassName = @"UICollectionViewCell";
    }
    
    return _cellClassName;
}

-(UICollectionViewFlowLayout *)collectionFLayout
{
    if (!_collectionFLayout) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionFLayout = layout;
    }
    
    return _collectionFLayout;
}

@end
