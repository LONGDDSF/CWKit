//
//  NSString+Transform.h
//  CWKit
//
//  Created by syswin on 2017/9/30.
//

#import <Foundation/Foundation.h>

@interface NSString (Transform)

/**
 检测单个字符是不是汉字
 */
+ (BOOL)isChineseChar:(unichar)charA;

/**
 是否全是汉字
 */
+ (BOOL)isChineseString:(NSString *)string;

/**
 检测是否包含汉字
 */
+ (BOOL)containsChinese:(NSString *)string;

/**
 转化成拼音
 只将汉字转化
 */
+ (NSString *)transformToPinyin:(NSString *)str;

@end
