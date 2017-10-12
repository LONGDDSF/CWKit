//
//  NSString+Search.m
//  CWKit
//
//  Created by syswin on 2017/10/12.
//

#import "NSString+Search.h"
#import "NSString+Transform.h"

@implementation NSString (Search)

- (NSRange)searchWithKey:(NSString *)subString
{
    NSRange rangeResult = NSMakeRange(0, 0);
    
    if (!subString || !self) {
        
        return rangeResult;
    }
    
    NSString *fullLowerString = [self lowercaseString];
    
    NSString *subLowerString = [subString lowercaseString];
    
    rangeResult = [fullLowerString rangeOfString:subLowerString];
    
    if (rangeResult.length > 0) {
        //完全匹配
        return rangeResult;
    }
    
    //有汉字时，都转化为拼音
    NSString *foundString = @"";
    
    BOOL hasFound = NO;
    
    NSInteger beginIdxFounded = 0;
    
    NSInteger idxAdd = 0;
    
    for (int idx = 0; idx < fullLowerString.length; idx ++) {
        
        NSRange tRange = NSMakeRange(idx , 1);
        
        NSString *idxString = [fullLowerString substringWithRange:tRange];
        
        NSString *objString = idxString;
        
        objString = [NSString transformToPinyin:idxString];
        
        if (foundString.length > 0) {
            
            if (![subLowerString containsString:foundString]) {
                
                idxAdd --;
                //非子集关系，只有部分匹配，不符合
                break;
                
            }else{
                
                //已经找到不分匹配，然后依次拼接余下的字符串
                idxAdd ++;
                
                foundString = [NSString stringWithFormat:@"%@%@",foundString,objString];
            }
            
        }else{
            
            //分包含、被包含两种case
            NSRange bRange = [objString rangeOfString:subLowerString];
            
            if (bRange.length > 0) {
                //包含
                if (bRange.location == 0) {
                    
                    //只从首位开始匹配
                    hasFound = YES;
                    idxAdd ++;
                    
                    beginIdxFounded = idx;
                    
                    break;
                }
                
            }else{
                
                //被包含
                NSRange aRange = [subLowerString rangeOfString:objString];
                
                //找到第一个匹配位置
                if (aRange.length > 0) {
                    
                    if (aRange.location == 0) {
                        
                        //记录找到的起始位置
                        beginIdxFounded = idx;
                        
                        idxAdd ++;
                        
                        foundString = [NSString stringWithFormat:@"%@%@",foundString,objString];
                    }
                }
            }
        }
        
        //判断结果
        if ([foundString containsString:subLowerString]) {
            
            //子集关系，说明已经找到，且完全匹配
            hasFound = YES;
            
            break;
        }
    }
    
    if (hasFound) {
        
        rangeResult = NSMakeRange(beginIdxFounded,idxAdd);
    }
    
    return rangeResult;
}

@end
