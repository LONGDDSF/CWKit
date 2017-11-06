//
//  TNSelectFeedMenu.h
//  CWKit
//
//  Created by syswin on 2017/11/3.
//

#import "TNSelectItemMenu.h"
#import "TNSelectFeedListInterator.h"

@interface TNSelectFeedMenu : TNSelectItemMenu

- (void)reloadData;

- (void)exchangeSelectedItemWithFeedID:(NSString *)feedID;

- (void)reloadDataWithFeedID:(NSString *)feedID model:(void(^)(TNSelectItemCellModel *model))modelBlock;

@end
