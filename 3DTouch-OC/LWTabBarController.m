//
//  LWTabBarController.m
//  3DTouch-OC
//
//  Created by 张星星 on 16/10/27.
//  Copyright © 2016年 张星星. All rights reserved.
//

#import "LWTabBarController.h"
#import "LWViewController.h"
#import "LWTableViewController.h"

@interface LWTabBarController ()

@end

@implementation LWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LWViewController *homeVC = [[LWViewController alloc]init];
    [self addChildViewController:homeVC image:@"tabbar_home" title:@"首页"];
    LWTableViewController *meVC = [[LWTableViewController alloc]init];
    [self addChildViewController:meVC image:@"tabbar_profile" title:@"我"];
    
}

- (void)addChildViewController:(UIViewController *)childController image:(NSString *)image title:(NSString *)title {
    // tabBar的图片,并且以最原始的状态显示
    childController.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",image]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // tabBar的文字
    childController.tabBarItem.title = title;
    // tabBar的文字颜色
    self.tabBar.tintColor = [UIColor orangeColor];
    // 控制器包装一层navigation
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
    // 导航条的title
    childController.navigationItem.title = title;
    // 添加到控制器中
    [self addChildViewController:nav];
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
