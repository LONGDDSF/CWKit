//
//  TNListViewInteractor.h
//  AFNetworking
//
//  Created by syswin on 2017/11/2.
//

#import <Foundation/Foundation.h>

@interface TNListViewInteractor : NSObject

@property (strong, nonatomic) NSMutableArray <NSArray *>*dataArray;

@property (strong, nonatomic) NSMutableArray *sectionTitles;

- (NSArray *)dataArrayAtSection:(NSInteger)section;

- (id)modelAtIndexPath:(NSIndexPath *)indexPath;

@end
