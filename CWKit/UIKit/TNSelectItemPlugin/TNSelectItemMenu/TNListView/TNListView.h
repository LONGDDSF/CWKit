//
//  TNListView.h
//  TNSearchVC
//
//  Created by syswin on 2017/10/30.
//  Copyright © 2017年 LONGDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNListViewConfig.h"
#import "TNListViewInteractor.h"

typedef void(^TNLBlockConifg)(TNListViewConfig *config);

@interface TNListView : UIView

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) TNListViewConfig *viewConfig;


+ (instancetype)listView;

- (void)updateWithConfig;

@end
