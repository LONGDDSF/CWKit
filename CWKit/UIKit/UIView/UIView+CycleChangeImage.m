//
//  UIView+CycleChangeImage.m
//  CWKit
//
//  Created by syswin on 2018/1/15.
//

#import "UIView+CycleChangeImage.h"
#import <objc/runtime.h>
#import "Masonry.h"

static char keyRuntimeSetCCIbtn;
static char keyRuntimeSetCCIidx;
static char keyRuntimeSetCCIDicImageAndStates;
static char keyRuntimeSetCCIblockDidChangeImage;

@implementation UIView (CycleChangeImage)

@dynamic cycleImageChangebtn;
@dynamic curSelIdx;
@dynamic dicImgAndStates;
@dynamic blockDidChangeImage;

- (void)setBlockDidChangeImage:(void (^)(id))blockDidChangeImage
{
    objc_setAssociatedObject(self, &keyRuntimeSetCCIblockDidChangeImage, blockDidChangeImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))blockDidChangeImage
{
    return objc_getAssociatedObject(self, &keyRuntimeSetCCIblockDidChangeImage);
}

-(void)setDicImgAndStates:(NSDictionary *)dicImgAndStates
{
    objc_setAssociatedObject(self, &keyRuntimeSetCCIDicImageAndStates, dicImgAndStates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)dicImgAndStates
{
    NSDictionary *dic = objc_getAssociatedObject(self, &keyRuntimeSetCCIDicImageAndStates);
    
    return dic;
}

- (void)setCurSelIdx:(NSInteger)curSelIdx
{
    objc_setAssociatedObject(self, &keyRuntimeSetCCIidx, @(curSelIdx), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)curSelIdx
{
    NSNumber *idx = objc_getAssociatedObject(self, &keyRuntimeSetCCIidx);
    
    return idx.integerValue;
}

-(void)setCycleImageChangebtn:(UIButton *)cycleImageChangebtn
{
    objc_setAssociatedObject(self, &keyRuntimeSetCCIbtn, cycleImageChangebtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)cycleImageChangebtn
{
    UIButton *view = objc_getAssociatedObject(self, &keyRuntimeSetCCIbtn);
    
    if (!view || ![view isKindOfClass:[UIButton class]]) {
        
        view = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.cycleImageChangebtn = view;
    }
    
    return view;
}

#pragma mark - ------------------ <#title#>


-(void)upadteWithDic:(NSDictionary *)imageAndValueDic
{
    self.dicImgAndStates  = imageAndValueDic;

    if (!self.cycleImageChangebtn.superview) {
        
        [self addSubview:self.cycleImageChangebtn];
        
        [self.cycleImageChangebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
        
        [self.cycleImageChangebtn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self updateBtnImage];
}

- (void)btnDidClick
{
    self.curSelIdx ++;
    
    if (self.curSelIdx > ( self.dicImgAndStates.allKeys.count - 1) ) {
        
        self.curSelIdx = 0;
    }
    
    [self updateBtnImage];
}

- (void)updateBtnImage
{
    UIImage *img = [[self tool_allImages] objectAtIndex:self.curSelIdx];
    
    [self.cycleImageChangebtn setImage:img forState:UIControlStateNormal];
    
    id ccState = [[self tool_allStates] objectAtIndex:self.curSelIdx];
    
    if (self.blockDidChangeImage) {
        
        self.blockDidChangeImage(ccState);
    }
}

- (NSArray *)tool_allImages
{
    NSArray *allImages = self.dicImgAndStates.allValues;
    
    return allImages;
}

- (NSArray *)tool_allStates
{
    NSArray *allStates = self.dicImgAndStates.allKeys;
    
    return  allStates;
}

@end
