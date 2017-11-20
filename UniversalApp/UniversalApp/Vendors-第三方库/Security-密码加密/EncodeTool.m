//
//  EncodeTool.m
//  Notes
//
//  Created by Apple on 16/9/13.
//  Copyright © 2016年 叶炯. All rights reserved.
//

#import "EncodeTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncodeTool
// 32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    if (isUppercase) {
        return   [result uppercaseString];
    }else{
        return result;
    }
    
}

// 16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString isUppercase:NO];
    
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    if (isUppercase) {
        return   [result uppercaseString];
    }else{
        return result;
    }
    
}





@end
