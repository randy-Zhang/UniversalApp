//
//  AESCrypt.h
//  cn.tyj.igod
//
//  Created by Mac on 14/12/16.
//  Copyright (c) 2014年 tyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import "Base64Util.h"
#define aes_key @"00wWw.tiYujie.CN"

@interface AESCrypt : NSObject
+ (NSString *)encrypt:(NSString *)text;
+ (NSString *)decrypt:(NSString *)ciphertext;
@end
