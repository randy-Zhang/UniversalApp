//
//  PayManager.m
//  UniversalApp
//
//  Created by alading on 2017/11/20.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import "PayManager.h"
#import "WXApi.h"

@implementation PayManager

- (void)payWithWX:(NSDictionary *)payResponse{
    
    NSMutableString *stamp  = [payResponse objectForKey:@"timestamp"];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [payResponse objectForKey:@"partnerid"];
    req.prepayId            = [payResponse objectForKey:@"prepayid"];
    req.nonceStr            = [payResponse objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [payResponse objectForKey:@"package"];
    req.sign                = [payResponse objectForKey:@"sign"];
    [WXApi sendReq:req];
    //日志输出
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[payResponse objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
}



@end
