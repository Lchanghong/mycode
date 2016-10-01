//
//  RNNavigationController.m
//  百思不得姐
//
//  Created by rain on 16/10/1.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNNavigationController.h"

@interface RNNavigationController ()

@end

@implementation RNNavigationController

/***第一次使用时设置背景颜色***/
+(void)initialize{
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    //设置导航控制器的背景颜色
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    RNLOGFUNC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//自定义push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    RNLOGFUNC;
    if (self.childViewControllers.count > 0) {//push进来的不是第一个控制器就自定义返回按钮
        //设置push返回按钮
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        //设置按钮尺寸
//      CGFloat width = backButton.currentBackgroundImage.size.width;
//      CGFloat height = backButton.currentBackgroundImage.size.height;
//      backButton.frame = CGRectMake(0, 0, width, height);
//      [backButton sizeToFit];
        CGFloat width = 70;
        CGFloat height = 30;
        backButton.frame = CGRectMake(0, 0, width, height);
        //设置左对齐
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
//        backButton.backgroundColor = [UIColor blueColor];
        [backButton addTarget:self action:@selector(black) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
    }
    [super pushViewController:viewController animated:YES];
}

- (void)black
{
    [self popViewControllerAnimated:YES];

}

@end
