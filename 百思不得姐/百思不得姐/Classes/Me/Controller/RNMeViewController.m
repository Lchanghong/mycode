//
//  RNMeViewController.m
//  百思不得姐
//
//  Created by rain on 16/9/30.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNMeViewController.h"

@interface RNMeViewController ()

@end

@implementation RNMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    //创建控制器左边按钮
    UIBarButtonItem *setButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" addTarget:self action:@selector(setTagClick)];
        
    //创建控制器左边按钮
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" addTarget:self action:@selector(moonTagClick)];
    self.navigationItem.rightBarButtonItems = @[setButton,moonButton
                                               
                                               ];
}
- (void)setTagClick
{
    RNLOGFUNC;

}

- (void)moonTagClick
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
