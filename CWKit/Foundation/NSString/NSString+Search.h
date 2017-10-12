//
//  NSString+Search.h
//  CWKit
//
//  Created by syswin on 2017/10/12.
//

#import <Foundation/Foundation.h>

@interface NSString (Search)

#pragma mark - ------------------ search Pin yin

//搜索subString，并返回首个符合的字符串位置，支持拼音搜索
- (NSRange)searchWithKey:(NSString *)searchKey;

@end
