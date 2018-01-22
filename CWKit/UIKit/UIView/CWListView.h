//
//  CWListView.h
//  CWKit
//
//  Created by syswin on 2018/1/22.
//

#import <UIKit/UIKit.h>

static const NSInteger kCWListViewCountOfRow = 4;

typedef void(^BlockListItemConfig)(UIView *itemView, NSInteger idx);

//@protocol CWListViewDataSource
//
//- (NSInteger)numberInPerRow;
//
//- (UIView *)viewForIndex:(NSInteger)idx;
//
//@end

@interface CWListView : UIView

//@property (weak, nonatomic) id <CWListViewDataSource>dataSource;

//四周边距
@property (assign, nonatomic) UIEdgeInsets cEdgeInsets;

//item在每个小空间的位置
@property (assign, nonatomic) UIEdgeInsets itemEdgeInsets;

//每一行的个数
@property (assign, nonatomic) NSInteger countOfPerRow;

- (void)reloadDataWithTotleCount:(NSInteger)count itemConfig:(BlockListItemConfig)blockConfig;

@end
