//
//  RNNewPostViewController.m
//  百思不得姐
//
//  Created by rain on 16/9/30.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNNewPostViewController.h"

@interface RNNewPostViewController ()

@end

@implementation RNNewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"MainTitle"]];
    //创建控制器左边按钮
    UIBarButtonItem *leftBarbtnItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" addTarget:self action:@selector(tagClick)];
    self.navigationItem.leftBarButtonItem = leftBarbtnItem;
}

/***监听左边item点击***/
- (void)tagClick
{
    RNLOGFUNC;
    
    
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
