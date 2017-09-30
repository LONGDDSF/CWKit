//
//  UIDevice+Ext.m
//  funlive
//
//  Created by l.t.zero on 16/8/18.
//  Copyright © 2016年 renzhen. All rights reserved.
//

#import "UIDevice+Ext.h"

#import <sys/sysctl.h>

@implementation UIDevice(DeviceExt)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

+ (BOOL)beforePlatform:(NSUInteger)version{
    NSString *platform = [UIDevice platform];
    
    if ([platform isEqualToString:@"iPhone se"]){
        return version >= 5;
    }
    
    if ([platform hasPrefix:@"iPhone"]){
        
        NSString *p = [platform substringWithRange:NSMakeRange(7, 1)];
        return p.integerValue <= version;
    }
    
    return NO;
}
+ (NSString *)platform{
     size_t size;
     sysctlbyname("hw.machine", NULL, &size, NULL, 0);
     char *machine = malloc(size);
     sysctlbyname("hw.machine", machine, &size, NULL, 0);
     NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
     free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone se";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
     return platform;
 }

- (NSInteger)availableVersion:(NSString *)version{
    NSArray *currentSystemVersion = [self.systemVersion componentsSeparatedByString:@"."];
    NSArray *comparedVersion = [version componentsSeparatedByString:@"."];
    
    NSInteger compared = 0;
    for(size_t i = 0; i < MIN(currentSystemVersion.count, comparedVersion.count); i++){
        NSInteger vCurrent = [currentSystemVersion[i] integerValue];
        NSInteger vCompared = [comparedVersion[i] integerValue];
        
        if ((compared = (vCompared - vCurrent)) != 0){
            break;
        }
    }
    
    return compared == 0? (comparedVersion.count - currentSystemVersion.count):compared;
}

@end
