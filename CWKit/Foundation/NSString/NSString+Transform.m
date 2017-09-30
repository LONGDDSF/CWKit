//
//  NSString+Transform.m
//  CWKit
//
//  Created by syswin on 2017/9/30.
//

#import "NSString+Transform.h"

@implementation NSString (Transform)

#pragma mark -- --------- Chinese

+ (BOOL)isChineseChar:(unichar)charA
{
    BOOL abool = NO;
    
    if( charA >= 0x4e00 && charA < 0x9fff) {
        abool = YES;
    }
    
    return abool;
}

+ (BOOL)containsChinese:(NSString *)string
{
    BOOL isContain = NO;
    
    for(int i = 0; i < string.length; i++) {
       
        int a = [string characterAtIndex:i];

        if ([NSString isChineseChar:a]) {
           
            isContain = YES;
            
            break;
        }
    }
    
    return isContain;
}

+ (BOOL)isChineseString:(NSString *)string
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

+ (NSString *)transformToPinyin:(NSString *)str {
    
    if ([NSString containsChinese:str]){
        
        NSMutableString *mutableString = [NSMutableString stringWithString:str];
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        return mutableString;
        
    }else{
        
        return str;
    }
}

@end
