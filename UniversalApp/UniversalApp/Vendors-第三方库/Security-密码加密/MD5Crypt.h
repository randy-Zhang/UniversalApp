//
//  MD5Crypt.h
//  demo
//
//  Created by jeffers on 16/5/11.
//  Copyright © 2016年 cloudcns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface MD5Crypt : NSObject
+(NSString *)MD5:(NSString *)text;
@end
