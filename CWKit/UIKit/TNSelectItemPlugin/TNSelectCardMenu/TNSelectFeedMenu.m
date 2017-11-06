//
//  TNSelectFeedMenu.m
//  CWKit
//
//  Created by syswin on 2017/11/3.
//

#import "TNSelectFeedMenu.h"

@implementation TNSelectFeedMenu

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.animateShowView.tnInteractor = [[TNSelectFeedListInterator alloc] init];
    }
    
    return self;
}

- (void)reloadData
{
    [super reqDataAndReload];
    
    [[self aInteractor] reqAllCards];
}

- (void)exchangeSelectedItemWithFeedID:(NSString *)feedID
{
    TNSelectItemCellModel *model = [[self aInteractor] modelWithFeedId:feedID];
    
    [self exchangeCurrentSelectItem:model];
}

-(void)reloadDataWithFeedID:(NSString *)feedID model:(void (^)(TNSelectItemCellModel *))modelBlock
{
    [[self aInteractor] reloadDataWithFeedID:feedID model:modelBlock];
}

- (TNSelectFeedListInterator *)aInteractor
{
    return self.animateShowView.tnInteractor;
}

@end
