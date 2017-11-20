//
//  MD5Crypt.m
//  demo
//
//  Created by jeffers on 16/5/11.
//  Copyright © 2016年 cloudcns. All rights reserved.
//

#import "MD5Crypt.h"

@implementation MD5Crypt
+(NSString *)MD5:(NSString *)text
{
    if (!text) {
        return nil;
    }
    NSData *data=[text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[16];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
