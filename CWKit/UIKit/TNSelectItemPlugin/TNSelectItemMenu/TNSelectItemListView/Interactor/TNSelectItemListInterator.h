//
//  TNSelectItemListInterator.h
//  AFNetworking
//
//  Created by syswin on 2017/11/2.
//

#import "TNListViewInteractor.h"

#import "TNSelectItemCellModel.h"

@interface TNSelectItemListInterator : TNListViewInteractor

@property (copy, nonatomic) void(^blockDidGetAllData)(BOOL success);

@property (strong, nonatomic) TNSelectItemCellModel *currentSelectModel;

- (void)test_reqAllData;

- (void)exchangeCurrentSelectItem:(TNSelectItemCellModel *)model;

@end
