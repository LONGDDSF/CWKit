//
//  TNListViewInteractor.m
//  AFNetworking
//
//  Created by syswin on 2017/11/2.
//

#import "TNListViewInteractor.h"

@implementation TNListViewInteractor

#pragma mark - ------------------ private

- (NSArray *)dataArrayAtSection:(NSInteger)section
{
    NSArray *sections = nil;
    
    NSArray *temp = [self.dataArray objectAtIndex:section];
    
    if ([temp isKindOfClass:[NSArray class]]) {
        
        sections = temp;
    }
    
    return sections;
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [self dataArrayAtSection:indexPath.section];
    
    id model = [arr objectAtIndex:indexPath.row];
    
    return model;
}

#pragma mark - ------------------ set / get

- (NSMutableArray<NSArray *> *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return _dataArray;
}

- (NSMutableArray *)sectionTitles
{
    if (!_sectionTitles) {
        
        _sectionTitles = [[NSMutableArray alloc] init];
    }
    
    return _sectionTitles;
}

@end
