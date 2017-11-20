//
//  UserManager.m
//  UniversalApp
//
//  Created by alading on 2017/11/13.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import "UserManager.h"
//#import <UMSocialCore/UMSocialCore.h>

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

/**
#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion{
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == kUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    }else if (loginType == kUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    }else{
        platFormType = UMSocialPlatformType_UnKnown;
    }
    //第三方登录
    if (loginType != kUserLoginTypePwd) {
        [MBProgressHUD showActivityMessageInView:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                
                UMSocialUserInfoResponse *resp = result;
                //
                //                // 授权信息
                //                NSLog(@"QQ uid: %@", resp.uid);
                //                NSLog(@"QQ openid: %@", resp.openid);
                //                NSLog(@"QQ accessToken: %@", resp.accessToken);
                //                NSLog(@"QQ expiration: %@", resp.expiration);
                //
                //                // 用户信息
                //                NSLog(@"QQ name: %@", resp.name);
                //                NSLog(@"QQ iconurl: %@", resp.iconurl);
                //                NSLog(@"QQ gender: %@", resp.unionGender);
                //
                //                // 第三方平台SDK源数据
                //                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                
                //登录参数
                NSDictionary *params = @{@"openid":resp.openid, @"nickname":resp.name, @"photo":resp.iconurl, @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2, @"cityname":resp.originalResponse[@"city"], @"fr":@(loginType)};
                
                self.loginType = loginType;
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    }else{
        //账号登录 暂未提供
    }
}
 */

#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    
    //网络请求
    NSDictionary * data = @{@"photo":@"",
                            @"nickname":@"张三",
                            @"sex":@"1",
                            @"degreeId":@"2",
                            @"signature":@"你好啊",
                            @"token":@"#dhasfsalfj1",
                            @"idcard":@"111",};
    
    [self LoginSuccess:data completion:completion];
    
    [MBProgressHUD hideHUD];
}

#pragma mark ————— 自动登录到服务器 —————
-(void)autoLoginToServer:(loginBlock)completion{
    
    //网络请求
}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
    
    if (completion) {
        self.curUserInfo = [UserInfo modelWithDictionary:responseObject];
        [self saveUserInfo];
        self.isLogined = YES;
        completion(YES,nil);
    }
    
//    if (ValidDict(responseObject)) {
//        if (ValidDict(responseObject[@"data"])) {
//            NSDictionary *data = responseObject[@"data"];
//            if (ValidStr(data[@"imId"]) && ValidStr(data[@"imPass"])) {
//                //登录IM
//                
//            }else{
//                KPostNotification(KNotificationLoginStateChange, @NO);
//            }
//            
//        }
//    }else{
//        
//        KPostNotification(KNotificationLoginStateChange, @NO);
//    }
    
}

#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
    
}

#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark ————— 被踢下线 —————
-(void)onKick{
    [self logout:nil];
}

#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    self.curUserInfo = nil;
    self.isLogined = NO;
    
    //    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}

@end

