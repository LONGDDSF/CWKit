//
//  NSString+Verify.m
//  CWKit
//
//  Created by syswin on 2017/10/24.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+[A-Za-z0-9.-]+[A-Za-z0-9-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    
    NSString *phoneRegex = @"^[1][3,4,5,7,8]+\\d{9}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSString *realMobile = [mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return [phoneTest evaluateWithObject:realMobile];
}


+ (BOOL) isIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0){
        
        return NO;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *identityCardPredicate = [NSPredicate
                                          
                                          predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}


+ (BOOL) isBankCard:(NSString *)cardNumber

{
    if(cardNumber.length==0){
        
        return NO;
    }
    
    NSString *digitsOnly = @"";
    
    char c;
    
    for (int i = 0; i < cardNumber.length; i++){
       
        c = [cardNumber characterAtIndex:i];
        
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    
    int sum = 0;
    
    int digit = 0;
    
    int addend = 0;
    
    BOOL timesTwo = false;
    
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
       
        digit = [digitsOnly characterAtIndex:i] - '0';
        
        if (timesTwo){
            
            addend = digit * 2;
            
            if (addend > 9) {
                
                addend -= 9;
            }
            
        }else {
            
            addend = digit;
        }
        
        sum += addend;
        
        timesTwo = !timesTwo;
    }
    
    int modulus = sum % 10;
    
    return modulus == 0;
}

@end
