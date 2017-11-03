//
//  TNSelectFeedMenu.h
//  CWKit
//
//  Created by syswin on 2017/11/3.
//

#import "TNSelectItemMenu.h"

@interface TNSelectFeedMenu : TNSelectItemMenu

- (void)exchangeSelectItemWithFeedID:(NSString *)feedID;

- (void)reloadDataWithFeedID:(NSString *)feedID model:(void(^)(TNSelectItemCellModel *model))modelBlock;

@end
