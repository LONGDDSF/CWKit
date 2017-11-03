//
//  TNSelectItemListInterator.m
//  AFNetworking
//
//  Created by syswin on 2017/11/2.
//

#import "TNSelectItemListInterator.h"

@implementation TNSelectItemListInterator

- (void)test_reqAllData
{
    
    [self testData];
    
    if (self.blockDidGetAllData) {
        
        self.blockDidGetAllData(YES);
    }
}

- (void)testData
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 300; i ++) {
        
        TNSelectItemCellModel *model = [[TNSelectItemCellModel alloc] init];
        
        model.title = [NSString stringWithFormat:@"title ********************___--- %d",i];
        model.image = [UIImage imageNamed:@"selectItemCell"];
        
        model.msgAlertCount = i;
        
        [arr addObject:model];
    }
    
    self.currentSelectModel = arr.firstObject;
    
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObject:arr];
}

- (void)exchangeCurrentSelectItem:(TNSelectItemCellModel *)model
{
    self.currentSelectModel.isSelected = NO;
    
    model.isSelected = YES;
    
    if (self.blockDidGetAllData) {
        
        self.blockDidGetAllData(YES);
    }
}

@end
