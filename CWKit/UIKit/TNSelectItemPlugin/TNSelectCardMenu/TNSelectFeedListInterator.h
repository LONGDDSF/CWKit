//
//  TNSelectFeedListInterator.h
//  CWKit
//
//  Created by syswin on 2017/11/3.
//

#import "TNSelectItemListInterator.h"

@interface TNSelectFeedListInterator : TNSelectItemListInterator

- (void)reqAllCards;

- (TNSelectItemCellModel *)modelWithFeedId:(NSString *)feedID;

- (void)reloadDataWithFeedID:(NSString *)feedID model:(void(^)(TNSelectItemCellModel *model))modelBlock;

@end
