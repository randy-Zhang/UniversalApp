//
//  LaunchAdModel.h/ qianguan
//
//  Created by alading on 2017/10/24.
//  Copyright © 2017年 QS_Ren. All rights reserved.
//
//  广告数据模型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LaunchAdModel : NSObject

/**
 *  广告URL
 */
@property (nonatomic, copy) NSString *content;

/**
 *  点击打开连接
 */
@property (nonatomic, copy) NSString *openUrl;

/**
 *  广告分辨率 （全屏750*1336 半屏1242*1596）
 */
@property (nonatomic, copy) NSString *contentSize;

/**
 *  广告停留时间
 */
@property (nonatomic, assign) NSInteger duration;

/**
 广告类型
 */
@property (nonatomic, assign) NSInteger adType;

/**
 *  分辨率宽
 */
@property(nonatomic,assign,readonly)CGFloat width;
/**
 *  分辨率高
 */
@property(nonatomic,assign,readonly)CGFloat height;

/**
 是否显示签到
 */
@property (nonatomic, assign) NSInteger isSign;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
