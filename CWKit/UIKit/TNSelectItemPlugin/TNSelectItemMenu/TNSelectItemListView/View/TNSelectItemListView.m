//
//  TNSelectItemListView.m
//  AFNetworking
//
//  Created by syswin on 2017/10/30.
//

#import "TNSelectItemListView.h"

#import "TNSelectItemCell.h"

@implementation TNSelectItemListView

#pragma mark - ------------------ life cycle

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.viewConfig.cellClassName = @"TNSelectItemCell";
        
        [self.viewConfig.collectionFLayout setMinimumLineSpacing:5];
        
        [self.viewConfig.collectionFLayout setMinimumInteritemSpacing:5];
    }
    
    return self;
}

- (void)reloadData
{
    [self updateWithConfig];
    
    [self.collectionView reloadData];
}

#pragma mark - ------------------ private


#pragma mark - ------------------ collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger count = 0;
    
    count = self.tnInteractor.dataArray.count;
    
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    
    count = [self.tnInteractor dataArrayAtSection:section].count;
    
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TNSelectItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.viewConfig.cellClassName forIndexPath:indexPath];
 
    id obj = [self.tnInteractor modelAtIndexPath:indexPath];
    
    [cell loadCellWithModel:obj];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat wSpecae = 0;
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        wSpecae = [(UICollectionViewFlowLayout *)collectionViewLayout minimumInteritemSpacing];
    }
    
    CGFloat w = ( collectionView.frame.size.width - (self.countOfPerLine-1) * wSpecae )/ self.countOfPerLine;

    CGFloat h = 75;

    CGSize size = CGSizeMake(w, h);

    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TNSelectItemCellModel *model = [self.tnInteractor modelAtIndexPath:indexPath];
    
    if (self.blockDidSelectedModel) {
        
        self.blockDidSelectedModel(model);
    }
}

#pragma mark - ------------------  get / set

- (TNSelectItemListInterator *)tnInteractor
{
    if (!_tnInteractor) {
        
        _tnInteractor = [[TNSelectItemListInterator alloc] init];
    }
    
    return _tnInteractor;
}

- (NSInteger)countOfPerLine
{
    if (_countOfPerLine <= 0) {
        
        _countOfPerLine = 1;
    }
    
    return _countOfPerLine;
}

@end
