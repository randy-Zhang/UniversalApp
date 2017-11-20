//
//  ShareManager.h
//  UniversalApp
//
//  Created by alading on 2017/11/14.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 分享相关服务
 */
@interface ShareManager : NSObject
/**
 单例
 */
SINGLETON_FOR_HEADER(ShareManager);

/**
 展示分享页面
 */
- (void)showShareView;

@end
