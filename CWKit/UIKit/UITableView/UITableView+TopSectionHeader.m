//
//  UITableView+TopSectionHeader.m
//  TestTableIndexPrj
//
//  Created by syswin on 2017/10/13.
//  Copyright © 2017年 luhongdeng. All rights reserved.
//

#import "UITableView+TopSectionHeader.h"
#import <objc/runtime.h>

@implementation UITableView (TopSectionHeader)

#pragma mark - ------------------ public

- (void)ts_willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSArray <NSIndexPath *>*arr = self.indexPathsForVisibleRows;
    
    //置为特殊状态
    NSIndexPath *firstpath = arr.firstObject;
    
    //表明是第一个
    if (section == firstpath.section) {
        
        //回掉
        if (self.headerViewChagedTo) {
            
            self.headerViewChagedTo(view);
        }
    }
    
    //滚动时，还原为默认状态
    if (arr.count >= 2) {
        
        NSIndexPath *secondtPath = [arr objectAtIndex:1];
        
        if (section == secondtPath.section - 1) {
            //表明是向上滚动,
            UITableViewHeaderFooterView *lastTopSecionHeaderView = [self headerViewForSection:secondtPath.section];
            
            if (self.headerViewChagedFrom) {
                
                self.headerViewChagedFrom(lastTopSecionHeaderView);
            }
        }
    }
}

- (void)ts_didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSArray *arr = self.indexPathsForVisibleRows;
    
    NSIndexPath *firstpath = arr.firstObject;
    
    if (self.headerViewChagedFrom) {
        
        self.headerViewChagedFrom(view);
    }
    
    //将topHeader置为特殊状态
    if (section + 1 == firstpath.section) {
        //表明是向下滚动，最新的topheader
        UITableViewHeaderFooterView *nextTopSecionHeaderView = [self headerViewForSection:firstpath.section];
        
        if (self.headerViewChagedTo) {
            
            self.headerViewChagedTo(nextTopSecionHeaderView);
        }
    }
}

#pragma mark - ------------------ set / get

static NSString *kHeaderViewChagedFrom;
static NSString *kHeaderViewChagedTo;

- (void)setHeaderViewChagedFrom:(TBSectionHeaderBlock)headerViewChagedFrom
{
    objc_setAssociatedObject(self, &kHeaderViewChagedFrom, headerViewChagedFrom, OBJC_ASSOCIATION_COPY);
}

- (TBSectionHeaderBlock)headerViewChagedFrom
{
    return objc_getAssociatedObject(self, &kHeaderViewChagedFrom);
}

- (void)setHeaderViewChagedTo:(TBSectionHeaderBlock)headerViewChagedTo
{
    objc_setAssociatedObject(self, &kHeaderViewChagedTo, headerViewChagedTo, OBJC_ASSOCIATION_COPY);
}

- (TBSectionHeaderBlock)headerViewChagedTo
{
    return objc_getAssociatedObject(self, &kHeaderViewChagedTo);
}


@end
