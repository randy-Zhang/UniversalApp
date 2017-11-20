//
//  EncodeTool.h
//  Notes
//
//  Created by Apple on 16/9/13.
//  Copyright © 2016年 叶炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncodeTool : NSObject

/**
 *  16位MD5加密方式（16个字节长度）
 *  经典的哈希算法不可逆
 *  @param srcString   加密的明文
 *  @param isUppercase 是否大写
 *
 *  @return 加密好的密文
 */
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
/**
 *  32位MD5加密方式(长度是32字节中间16位字节和16加密的结果相同)
 *  经典的哈希算法不可逆
 *  @param srcString 加密的明文
 *  @param isUppercase 是否大写
 *  @return 加密后的密文
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;

@end
