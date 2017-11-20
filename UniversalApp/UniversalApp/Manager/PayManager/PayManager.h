//
//  PayManager.h
//  UniversalApp
//
//  Created by alading on 2017/11/20.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define userManager [PayManager sharedPayManager]

@interface PayManager : NSObject

/**
 单例
 */
SINGLETON_FOR_HEADER(PayManager);

- (void)payWithWX:(NSDictionary *)payResponse;



@end
