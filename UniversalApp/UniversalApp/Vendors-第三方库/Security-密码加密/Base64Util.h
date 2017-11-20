//
//  Base64Util.h
//  cn.tyj.igod
//
//  Created by Mac on 14/12/16.
//  Copyright (c) 2014年 tyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Util : NSObject
+(NSString *)base64StringFromText:(NSString *)text;
+(NSString *)base64StringFromData:(NSData *)data;
+(NSString *)textFromBase64String:(NSString *)base64;
+(NSData *)dataFromBase64String:(NSString *)base64;
@end
