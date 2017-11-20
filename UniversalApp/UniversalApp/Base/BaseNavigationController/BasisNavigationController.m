//
//  BasisNavigationController.m
//  qianguan
//
//  Created by 李文全 on 17/3/23.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import "BasisNavigationController.h"

@interface BasisNavigationController ()

@end

@implementation BasisNavigationController

+ (void)initialize{
    
    // 对bar属性进行设置
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO;
    //设置导航栏的颜色
    bar.barTintColor = CNavBgColor;
    //设置bar上字体的大小,颜色
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : CNavBgFontColor}];
    
    [bar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    

    // 设置item属性进行设置
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    
    
}

//设置状态看的字体颜色为白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;//UIStatusBarStyleLightContent
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//拦截push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    //如果在控制器有设置，就可以让后面设置的按钮可以覆盖它
    [super pushViewController:viewController animated:animated];
    
}



@end
