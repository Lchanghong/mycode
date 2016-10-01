//
//  RNFriendTrendsViewController.m
//  百思不得姐
//
//  Created by rain on 16/9/30.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNFriendTrendsViewController.h"

@interface RNFriendTrendsViewController ()

@end

@implementation RNFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"我的关注";
    
    //创建控制器左边按钮
    UIBarButtonItem *friendsButton = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" addTarget:self action:@selector(tagClick)];
    self.navigationItem.leftBarButtonItem = friendsButton;
}

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
