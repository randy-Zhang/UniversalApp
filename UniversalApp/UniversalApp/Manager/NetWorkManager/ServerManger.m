//
//  ServerManger.m
//  qianguan
//
//  Created by alading on 2017/3/27.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import "ServerManger.h"
#import "MBProgressHUD.h"
#import "AESCrypt.h"
#import "UserManager.h"

////调用的URL
//#if DEBUG
//
//#define kBaseWebserviceUrl @"http://dev.saileikeji.com:10007/service/service"
//#define kResourceWebserviceUrl @"http://www.qianguan88.com/service/upload"
//
//#else
//
//#define kBaseWebserviceUrl @"http://www.qianguan88.com/servicev3/service"
//#define kResourceWebserviceUrl @"http://www.qianguan88.com/service/upload"
//
//#endif


//#define kBaseWebserviceUrl @"http://192.168.10.196:8080/money-pot-mobileserv/service"
//#define kBaseWebserviceUrl @"http://192.168.10.199:8081/money-pot-mobileserv/service"
//#define kBaseWebserviceUrl @"http://192.168.10.156:8081/service"
#define kBaseWebserviceUrl @"http://dev.saileikeji.com:10007/service/service"
//#define kResourceWebserviceUrl @"http://www.qianguan88.com/service/upload"
//#define kResourceWebserviceUrl @"http://192.168.10.199:8081/money-pot-mobileserv/upload"
//#define kResourceWebserviceUrl @"https://www.qianguan88.com/servicev3/upload"


//正式环境
//#define kBaseWebserviceUrl @"http://www.qianguan88.com/servicev3/service"
#define kResourceWebserviceUrl @"https://www.qianguan88.com/servicev3/upload"



//使用静态变量目的地减少程序的编译时间
static NSString * const kFunc_Ad = @"010"; //获取广告
static NSString * const kFunc_Init = @"000"; //初始化
static NSString * const kFunc_Login = @"001";//登录
static NSString * const kFunc_Reg = @"002"; //注册
static NSString * const kFunc_ResetPassword = @"003"; //忘记密码
static NSString * const kFunc_GetPictureCode = @"004"; //获取图片验证码
static NSString * const kFunc_AuthCode = @"005";//获取验证码
static NSString * const kFunc_CheckUpdate = @"006";//检查更新

@implementation ServerManger

NSString *const keyFriend=@"friends";

//单例只创建一次
+(instancetype)getInstance{
    static ServerManger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManger alloc] init];
    });
    
    return manager;
}


#pragma mark - 开屏广告
- (void)postLaunchAdSuccess:(successBlock)resultBlock
                    failure:(FailureBlock)failureBlock{
    //参数处理
    NSMutableDictionary *adParameters = [[NSMutableDictionary alloc] init];
    [adParameters setValue:kFunc_Ad forKey:@"func"];
    //上次请求广告id
    
    //发送网络请求
    [self netPostActionInParameters:adParameters succes:resultBlock failure:failureBlock];
}

#pragma mark- 001-登录
- (void)postUserLoginWithUserPhone:(NSString *)phone
                          Password:(NSString *)password
                            succes:(SuccessBlock)resultBlock
                           failure:(FailureBlock)failureBlock{
    //1用户参数处理
    NSMutableDictionary *userParameters = [NSMutableDictionary dictionary];
    //用户名
    userParameters[@"user_name"] = phone;
    //密码
    userParameters[@"password"] = [AESCrypt encrypt:password];//对密码进行加密处理
    //设备编号(设备的身份号)
    userParameters[@"device_id"] = curUser.token;
    //系统类型
    userParameters[@"os_type"] = @"2";
    //系统版本(手机系统是几 ,例如 10.2.1)
    userParameters[@"os_version"] = curUser.token;
    //设备型号(你的手机是iphone几 例如iPhone7,1)
    userParameters[@"device_model"] = curUser.token; //什么手机
    //appid
    userParameters[@"app_id"] = @"101200";
    //外部版本号
    userParameters[@"ver_name"] = curUser.token;
    //内部版本号
    userParameters[@"ver_code"] = curUser.token;
    
    //2传入参数处理
    NSMutableDictionary *inParameters = [NSMutableDictionary dictionary];
    inParameters[@"func"] = kFunc_Login;
    inParameters[@"params"] = userParameters;
    
    
    //发送网络请求
    [self netPostActionInParameters:inParameters succes:resultBlock failure:failureBlock];
}




#pragma mark- 002-注册
- (void)postUserRegisterWithPhone:(NSString *)phone
                        CheckCode:(NSString *)checkCode
                         Password:(NSString *)password
                         AreaCode:(NSString *)areaCode
                       InviteCode:(NSString *)inviteCode
                           succes:(SuccessBlock)resultBlock
                          failure:(FailureBlock)failureBlock{
    
    //1用户参数处理
    NSMutableDictionary *userParameters = [NSMutableDictionary dictionary];
    userParameters[@"user_name"] = phone;
    userParameters[@"password"] = [AESCrypt encrypt:password];;//对密码进行加密处理
    userParameters[@"county"]   = areaCode;
    userParameters[@"auth_code"]   = checkCode;
    userParameters[@"broker_code"]   = inviteCode;
    
    
    //2传入参数处理
    NSMutableDictionary *inParameters = [NSMutableDictionary dictionary];
    inParameters[@"func"] = kFunc_Reg;
    inParameters[@"params"] = userParameters;
    
    //网络请求
    [self netPostActionInParameters:inParameters succes:resultBlock failure:failureBlock];

}




#pragma mark- 003-重置密码
- (void)postUserForgetWithUserPhone:(NSString *)phone userId:(NSString*)userId
                           Password:(NSString *)password
                          CheckCode:(NSString *)checkCode
                             succes:(SuccessBlock)resultBlock
                            failure:(FailureBlock)failureBlock{
    
    //1用户参数处理
    NSMutableDictionary *userParameters = [NSMutableDictionary dictionary];
    userParameters[@"user_name"] = phone;
    userParameters[@"password"] = [AESCrypt encrypt:password];;//对密码进行加密处理
    userParameters[@"auth_code"]   = checkCode;
    
    //2传入参数处理
    NSMutableDictionary *inParameters = [NSMutableDictionary dictionary];
    inParameters[@"func"] = kFunc_ResetPassword;
    inParameters[@"params"] = userParameters;
    inParameters[@"user"] = userId;
    //网络请求
    [self netPostActionInParameters:inParameters succes:resultBlock failure:failureBlock];
    
}




#pragma mark-004-获取图片验证码
- (void)postGetPictureCodesucces:(SuccessBlock)resultBlock
                         failure:(FailureBlock)failureBlock{
    
    //1用户参数处理
    NSMutableDictionary *userParameters = [NSMutableDictionary dictionary];
    userParameters[@"token_id"] = curUser.token;
    
    //2传入参数处理
    NSMutableDictionary *inParameters = [NSMutableDictionary dictionary];
    inParameters[@"func"] = kFunc_GetPictureCode;
    inParameters[@"params"] = userParameters;
    
    
    //网络请求
    [self netPostActionInParameters:inParameters succes:resultBlock failure:failureBlock];

    
}




#pragma mark- 005-获取验证码
- (void)postSMSCode:(NSString *)phone
               Type:(NSNumber*)type
            tokenID:(NSString *)tokenID
            picCode:(NSString *)picCode
             succes:(SuccessBlock)resultBlock
            failure:(FailureBlock)failureBlock{
    
    //1用户参数处理
    NSMutableDictionary *userParameters = [NSMutableDictionary dictionary];
    userParameters[@"phone"] = phone;
    userParameters[@"type"] = type;//1 注册,2登录,3支付密码，4绑定手机号
    userParameters[@"token_id"] = tokenID;
    userParameters[@"pic_code"] = picCode;

    
    //2传入参数处理
    NSMutableDictionary *inParameters = [NSMutableDictionary dictionary];
    inParameters[@"func"] = kFunc_AuthCode;
    inParameters[@"params"] = userParameters;
    
    //网络请求
    [self netPostActionInParameters:inParameters succes:resultBlock failure:failureBlock];

}




#pragma mark- 006-检查更新
- (void)postCheckForUpdateVerCode:(NSString*)verCode
                          VerName:(NSString *)verName
                           succes:(SuccessBlock)resultBlock
                          failure:(FailureBlock)failureBlock{
    
    //1用户参数处理
    NSMutableDictionary *userParameters = [NSMutableDictionary dictionary];
    userParameters[@"app_id"] = @"101200";
    userParameters[@"ver_code"] = verCode;//内部版本号
    userParameters[@"ver_name"] = verName;// 外部版本号
    
    //2传入参数处理
    NSMutableDictionary *inParameters = [NSMutableDictionary dictionary];
    inParameters[@"func"] = kFunc_CheckUpdate;
    inParameters[@"params"] = userParameters;
    
    //网络请求
    [self netPostActionInParameters:inParameters succes:resultBlock failure:failureBlock];

}





#pragma mark- 上传图片
- (void)uploadPictureImageData:(NSData *)imageData
                        succes:(block)resultBlock
                       failure:(FailureBlock)failureBlock{
    
    
    [NetworkRequest uploadWithURL:kResourceWebserviceUrl parameters:nil imageData:imageData name:nil fileName:nil mimeType:nil progress:nil success:^(id responseObject) {
        
        if (responseObject != [NSNull class] && responseObject != nil) {
            
            if (resultBlock) {
                
                NSString *url=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                resultBlock(YES, url);
            }
        }
        
        
    } failure:^(NSError *error) {
        
        
        if (failureBlock) {
            failureBlock(error);
        }
        
    }];
    
    
}




#pragma mark- 公共网络调用方法
- (void)netPostActionInParameters:(NSMutableDictionary *)inParameters succes:(SuccessBlock)resultBlock failure:(FailureBlock)failureBlock{
    
    
    [NetworkRequest post:kBaseWebserviceUrl parameters:inParameters succes:^(NSDictionary *dic) {
        
        if (dic != [NSNull class] && dic != nil) {
            if (resultBlock) {
                resultBlock(dic);
            }
        }
    } failure:^(NSError *error) {
        
        if (failureBlock) {
            failureBlock(error);
        }
    }];

    
    
}




@end
