//
//  TNSelectFeedListInterator.m
//  CWKit
//
//  Created by syswin on 2017/11/3.
//

#import "TNSelectFeedListInterator.h"

@implementation TNSelectFeedListInterator


- (TNSelectItemCellModel *)modelWithFeedId:(NSString *)feedID
{
    __block TNSelectItemCellModel *resultModel = nil;
    
    [self.dataArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[TNSelectItemCellModel class]]) {
                
                TNSelectItemCellModel *model = (TNSelectItemCellModel *)obj;
                
                if (1) {
                    
                    resultModel = model;
                }
            }
        }];
    }];
    
    return resultModel;
}

- (void)reloadDataWithFeedID:(NSString *)feedID model:(void(^)(TNSelectItemCellModel *model))modelBlock
{
    self.currentFeedID = feedID;
    
    __weak typeof(self) wSelf = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        TNSelectItemCellModel *model = nil;
        
        model = [wSelf modelWithFeedId:feedID];
        
        if (modelBlock) {
            
            modelBlock(model);
        }
        
        if (wSelf.blockDidGetAllData) {
            
            wSelf.blockDidGetAllData(YES);
        }
    });
}



@end
