//
//  RNFriendTrendsViewController.m
//  百思不得姐
//
//  Created by rain on 16/9/30.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNFriendTrendsViewController.h"
#import "RNFriendsView.h"

@interface RNFriendTrendsViewController ()


@end

@implementation RNFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关注";
    
    //创建导航左边按钮
    UIBarButtonItem *leftButton = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" addTarget:self action:@selector(tagClick)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //自定义view
    RNFriendsView *view = [[RNFriendsView alloc] init];
    view.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:view];
    
    
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
