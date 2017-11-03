//
//  TNListViewModel.h
//  TNSearchVC
//
//  Created by syswin on 2017/10/30.
//  Copyright © 2017年 LONGDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TNListViewConfig : NSObject

//@required
@property (strong, nonatomic) NSString *cellClassName;

//@required
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionFLayout;

@end
