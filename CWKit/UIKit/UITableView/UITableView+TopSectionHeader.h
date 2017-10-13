//
//  UITableView+TopSectionHeader.h
//  TestTableIndexPrj
//
//  Created by syswin on 2017/10/13.
//  Copyright © 2017年 luhongdeng. All rights reserved.
//

/*
 基于UITableView有多个section情景，
 滑动时，引起吸顶的section headerView切换，
 将此时旧的、新的top section headerview找到并回掉出去
 如果你未自定义headerview，回调的是系统默认的UITableViewHeaderFooterView *view
 */

#import <UIKit/UIKit.h>

//definition a callBack
typedef void(^TBSectionHeaderBlock)(UIView *headerView);

@interface UITableView (TopSectionHeader)

// top section heaerview变化时，旧的top section Headerview
@property (copy, nonatomic) TBSectionHeaderBlock headerViewChagedFrom;

//top section heaerview变化时，新的top section Headerview
@property (copy, nonatomic) TBSectionHeaderBlock headerViewChagedTo;

//需要实现tableview的delegate 方法: - (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section，并在其中调用如下方法
- (void)ts_willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;

//需要实现tableview的delegate 方法 : - (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section，并在其中调用如下方法
- (void)ts_didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;

@end
