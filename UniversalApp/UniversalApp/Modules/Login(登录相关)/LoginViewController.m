//
//  LoginViewController.m
//  UniversalApp
//
//  Created by alading on 2017/11/13.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickSignInButton:(UIButton *)sender {
    
    [userManager loginToServer:nil completion:^(BOOL success, NSString *des) {
        
        [self skipAction];
    }];
}

#pragma mark - 发送登录成功通知
-(void)skipAction{
    KPostNotification(KNotificationLoginStateChange, @YES);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
