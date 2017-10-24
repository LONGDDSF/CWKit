//
//  NSString+Verify.h
//  CWKit
//
//  Created by syswin on 2017/10/24.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

//检测是否是email的格式
+ (BOOL)isValidateEmail:(NSString *)email;

//检测是否是手机号格式（忽略mobile中的空格）
+ (BOOL) isValidateMobile:(NSString *)mobile;

//身份证格式校验
+ (BOOL) isIdentityCard:(NSString *)IDCardNumber;

//银行卡格式校验
+ (BOOL) isBankCard:(NSString *)cardNumber;


@end
