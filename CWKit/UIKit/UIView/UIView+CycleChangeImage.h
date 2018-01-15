//
//  UIView+CycleChangeImage.h
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import <UIKit/UIKit.h>

//循环切换图片
@interface UIView (CycleChangeImage)

@property (strong, nonatomic) UIButton *cycleImageChangebtn;
@property (assign, nonatomic) NSInteger curSelIdx;
@property (strong, nonatomic) NSDictionary *dicImgAndStates;

@property (copy, nonatomic)void(^blockDidChangeImage)(id currentValue);

//key:states value:images
- (void)upadteWithDic:(NSDictionary *)imageAndStatesDic;

@end
