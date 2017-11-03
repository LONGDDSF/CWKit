//
//  TNSelectItemMenu.h
//  AFNetworking
//
//  Created by syswin on 2017/10/30.
//

#import <UIKit/UIKit.h>
#import "TNSelectItemListView.h"

@interface TNSelectItemMenu : UIView

@property (copy, nonatomic) void(^blockDidSelectItem) (id obj);

//弹窗显示的位置（default = keywindow）
@property (weak, nonatomic) UIView *menuContainerView;

@property (strong, nonatomic) TNSelectItemListView *animateShowView;

@property (strong, nonatomic, readonly) TNSelectItemCellModel *currentSelectItem;

- (void)reqDataAndReload;

- (void)didSelectedItem:(id)obj;

- (void)exchangeCurrentSelectItem:(TNSelectItemCellModel *)modelNew;

@end
