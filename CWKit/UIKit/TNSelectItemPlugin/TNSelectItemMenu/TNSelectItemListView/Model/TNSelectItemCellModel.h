//
//  TNSelectItemCellModel.h
//  AFNetworking
//
//  Created by syswin on 2017/10/30.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TNSelectItemCellDisPlayType) {
    TNSelectItemCellDisPlayTypeV,
    TNSelectItemCellDisPlayTypeH,
};

@interface TNSelectItemCellModel : NSObject

@property (assign, nonatomic) TNSelectItemCellDisPlayType cellType;

@property (strong, nonatomic) id obj;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *imageUrl;

@property (assign, nonatomic) NSInteger msgAlertCount;

// UI
@property (assign, nonatomic) CGFloat bottomLineSpaceLeft;
@property (assign, nonatomic) CGFloat bottomLineSpaceRight;

@property (assign, nonatomic) BOOL isSelected;

@end
