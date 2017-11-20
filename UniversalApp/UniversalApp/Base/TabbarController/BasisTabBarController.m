//
//  BasisTabBarController.m
//  qianguan
//
//  Created by 李文全 on 17/3/23.
//  Copyright © 2017年 李文全. All rights reserved.
//

#import "BasisTabBarController.h"
#import "BasisNavigationController.h"
#import "BasisTabBar.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"

@interface BasisTabBarController ()


@end

@implementation BasisTabBarController

+ (void)initialize{
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];//设置正常状态tab的字体
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];//设置正常状态tab的字体颜色
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];//设置选中状态tab的字体
    selectedAttrs[NSForegroundColorAttributeName] = CTabBgFontSelectedColor;//设置选中状态tab的字体
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听tabbar按钮的代理
    self.delegate = self;
    
    // 添加子控制器
    [self setupChildVc:[[HomeViewController alloc] init] title:@"主页" image:@"bar-qianguan-B" selectedImage:@"bar-qianguan-R"];
    [self setupChildVc:[[SecondViewController alloc] init] title:@"第二" image:@"bar-xiaoxi－B" selectedImage:@"bar-xiaoxi－R"];
    [self setupChildVc:[[ThirdViewController alloc] init] title:@"第三" image:@"bar-renmai-B" selectedImage:@"bar-renmai-R"];
    [self setupChildVc:[[FouthViewController alloc] init] title:@"第四" image:@"bar-shangcheng-B" selectedImage:@"bar-shangcheng-R"];
    
    // 更换tabBar
    [self setValue:[[BasisTabBar alloc] init] forKeyPath:@"tabBar"];
    

}



/**
 初始化子控制器

 @param vc 控制器实例
 @param title tabar的显示的名称
 @param image tabar上正常显示的图片
 @param selectedImage tabar上选中是显示的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BasisNavigationController *nav = [[BasisNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}



-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    [super setSelectedIndex:selectedIndex];
//    [self.myTabBar setSelectedItem:self.myTabBar.items[selectedIndex]];
}



#pragma mark - 处理点击选中按钮的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    

    
}

- (void)dealloc{
    
    
    
}



@end
