//
//  ServerManger.h
//  qianguan
//
//  Created by alading on 2017/3/27.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequest.h"

typedef void (^completion) (NSDictionary * dic);
typedef void(^FailureBlock)(NSError * error);
typedef void(^block)(BOOL success, NSString *imageUrl);

@interface ServerManger : NSObject

+(instancetype)getInstance;



//000-初始化(此处是设计安卓的不做处理)

/**
 获取开屏广告

 @param resultBlock 成功返回信息
 @param failure 失败返回信息
 */
- (void)postLaunchAdSuccess:(successBlock)resultBlock
                    failure:(FailureBlock)failureBlock;

/**
 001-登录
 @param phone 手机号
 @param password 密码
 @param resultBlock 登录成功返回的信息
 @param failureBlock 登录失败返回的信息
 */
- (void)postUserLoginWithUserPhone:(NSString *)phone
                          Password:(NSString *)password
                            succes:(SuccessBlock)resultBlock
                           failure:(FailureBlock)failureBlock;

/**
 002-注册
 @param phone 电话
 @param checkCode 短信验证码
 @param password 密码
 @param areaCode 地区编码
 @param inviteCode 邀请码
 @param resultBlock 注册成功返回的信息
 @param failureBlock 注册失败返回的信息
 */
- (void)postUserRegisterWithPhone:(NSString *)phone
                        CheckCode:(NSString *)checkCode
                         Password:(NSString *)password
                         AreaCode:(NSString *)areaCode
                       InviteCode:(NSString *)inviteCode
                           succes:(SuccessBlock)resultBlock
                          failure:(FailureBlock)failureBlock;






/**
 003-重置密码
 @param phone 手机号
 @param password 密码
 @param resultBlock 成功返回的信息
 @param failureBlock 失败返回的信息
 */
- (void)postUserForgetWithUserPhone:(NSString *)phone userId:(NSString*)userId
                           Password:(NSString *)password
                          CheckCode:(NSString *)checkCode
                             succes:(SuccessBlock)resultBlock
                            failure:(FailureBlock)failureBlock;


/**
 004-获取图片验证码
 @param resultBlock 成功返回的信息
 @param failureBlock 成功返回的信息
 */
- (void)postGetPictureCodesucces:(SuccessBlock)resultBlock
                         failure:(FailureBlock)failureBlock;



/**
 005-获取验证码
 @param phone 手机号
 @param type  类型:@1 注册 @2 重置密码
 @param resultBlock 成功返回的信息
 @param failureBlock 失败返回的信息
 */
- (void)postSMSCode:(NSString *)phone
               Type:(NSNumber*)type
            tokenID:(NSString *)tokenID
            picCode:(NSString *)picCode
             succes:(SuccessBlock)resultBlock
            failure:(FailureBlock)failureBlock;



/**
 006-检查更新
 
 @param verCode 内部版本号
 @param verName 外部版本号
 @param resultBlock 成功返回的信息
 @param failureBlock 失败返回的信息
 */
- (void)postCheckForUpdateVerCode:(NSString*)verCode
                          VerName:(NSString *)verName
                           succes:(SuccessBlock)resultBlock
                          failure:(FailureBlock)failureBlock;





/**
 上传图片
 
 @param imageData 图片数据
 @param resultBlock 成功返回的信息
 @param failureBlock 失败返回的信息
 */
- (void)uploadPictureImageData:(NSData *)imageData
                        succes:(block)resultBlock
                       failure:(FailureBlock)failureBlock;



@end
