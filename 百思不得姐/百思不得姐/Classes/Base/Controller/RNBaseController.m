//
//  RNBaseController.m
//  百思不得姐
//
//  Created by rain on 16/9/29.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNBaseController.h"
#import "RNEssenceViewController.h"
#import "RNMeViewController.h"
#import "RNNewPostViewController.h"
#import "RNFriendTrendsViewController.h"
#import "RNTabBar.h"
#import "RNNavigationController.h"

@interface RNBaseController ()

@end

@implementation RNBaseController

/***第一次创建时设置tabBar样式***/
+(void)initialize
{
    //创建item样式
    UITabBarItem *item = [UITabBarItem appearance];
    
    //设置默认字体大小,颜色属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [ item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    //设置选中字体大小,颜色属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [ item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    RNLOGFUNC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建精华控制器
    RNEssenceViewController *EssenceVC = [[RNEssenceViewController alloc] init];
    [self setupChildViewController:EssenceVC title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    //创建新帖控制器
    RNNewPostViewController *NewPostVC = [[RNNewPostViewController alloc] init];
    [self setupChildViewController:NewPostVC title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    //创建关注控制器
    RNFriendTrendsViewController *FollowVC = [[RNFriendTrendsViewController alloc] init];
    [self setupChildViewController:FollowVC title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    //创建我控制器
    RNMeViewController *MeVC = [[RNMeViewController alloc] init];
    [self setupChildViewController:MeVC title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换自定义TabBar
    [self setValue:[[RNTabBar alloc] init] forKey:@"TabBar"];
    
     
}

/***创建子控制器***/
- (void)setupChildViewController:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    //设置子控制器
    VC.tabBarItem.title = title;
    VC.navigationItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //添加子控制器到导航控制器
    RNNavigationController *nav = [[RNNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
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
