//
//  SecondViewController.m
//  UniversalApp
//
//  Created by alading on 2017/11/13.
//  Copyright © 2017年 SaiLei. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationItemWithTitles:@[@"分享"] isLeft:NO target:self action:@selector(clickShareButton) tags:@[@"1"]];
}

#pragma mark - 分享
- (void)clickShareButton{
    
    [[ShareManager sharedShareManager] showShareView];
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
