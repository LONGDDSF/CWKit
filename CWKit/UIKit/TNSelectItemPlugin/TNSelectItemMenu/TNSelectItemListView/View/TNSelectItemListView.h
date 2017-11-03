//
//  TNSelectItemListView.h
//  AFNetworking
//
//  Created by syswin on 2017/10/30.
//

#import "TNListView.h"

#import "TNSelectItemListInterator.h"


@interface TNSelectItemListView : TNListView <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//default is 1
@property (assign, nonatomic) NSInteger countOfPerLine;

@property (assign, nonatomic) TNSelectItemCellDisPlayType disPlayType;

@property (strong, nonatomic) TNSelectItemListInterator *tnInteractor;

@property (copy, nonatomic) void(^blockDidSelectedModel)(TNSelectItemCellModel *model);

- (void)reloadData;

- (NSIndexPath *)indexPathForItemModel:(TNSelectItemCellModel *)model;

- (void)reloadDataAtIndexPath:(NSIndexPath *)indexPath;

@end


