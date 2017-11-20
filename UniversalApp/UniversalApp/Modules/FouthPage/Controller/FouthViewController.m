//
//  FouthViewController.m
//  UniversalApp
//
//  Created by alading on 2017/11/13.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import "FouthViewController.h"

@interface FouthViewController ()

@end

@implementation FouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationItemWithTitles:@[@"退出"] isLeft:NO target:self action:@selector(signOut) tags:@[@"0"]];
}

- (void)signOut{
    
    DLog(@"退出登录");
    [userManager logout:^(BOOL success, NSString *des) {
        
    }];
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
