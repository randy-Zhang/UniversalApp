//
//  NetworkRequest.h
//  qianguan
//
//  Created by alading on 2017/3/27.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSObject
//请求超时
#define TIMEOUT 30.0f

typedef void(^SuccessBlock)(NSDictionary * dic);
typedef void(^FailureBlock)(NSError * error);
typedef void(^ProgressBlock)(NSProgress *progress);
typedef void(^successBlock)(id responseObject);

+ (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
     succes:(SuccessBlock)success
    failure:(FailureBlock)failure;

+ (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
      succes:(SuccessBlock)success
     failure:(FailureBlock)failure;

//上传多张图片
+ (void)uploadWithURL:(NSString *)URL
           parameters:(NSDictionary *)parameters
               images:(NSArray<UIImage *> *)images
                 name:(NSString *)name
             fileName:(NSString *)fileName
             mimeType:(NSString *)mimeType
             progress:(ProgressBlock)progress
              success:(SuccessBlock)success
              failure:(FailureBlock)failure;


//上传单张图片
+ (void)uploadWithURL:(NSString *)URL
           parameters:(NSDictionary *)parameters
            imageData:(NSData *)imageData
                 name:(NSString *)name
             fileName:(NSString *)fileName
             mimeType:(NSString *)mimeType
             progress:(ProgressBlock)progress
              success:(successBlock)success
              failure:(FailureBlock)failure;

@end
