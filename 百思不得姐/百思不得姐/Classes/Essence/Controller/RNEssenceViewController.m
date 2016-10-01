//
//  RNEssenceViewController.m
//  百思不得姐
//
//  Created by rain on 16/9/30.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNEssenceViewController.h"

@interface RNEssenceViewController ()

@end

@implementation RNEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.view.backgroundColor = RNVIEWBGCOLOR;
    
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //创建控制器左边按钮
    UIBarButtonItem *leftBarbtnItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" addTarget:self action:@selector(tagClick)];
    self.navigationItem.leftBarButtonItem = leftBarbtnItem;
    
    
}

/***监听左边item点击***/
- (void)tagClick
{
    RNLOGFUNC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:VC animated:YES ];

}

@end
