//
//  RNFriendsView.m
//  百思不得姐
//
//  Created by rain on 16/10/1.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNFriendsView.h"
#import <Masonry/Masonry.h>

@interface RNFriendsView ()
///***Icon***/
//@property (weak, nonatomic) UIImageView *Icon;
///***Friendslable***/
//@property (weak, nonatomic) UILabel *Lable;
///***loginButton***/
//@property (weak, nonatomic) UIButton *LoginButton;

@end

@implementation RNFriendsView

/***创建子控件***/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RNVIEWBGCOLOR;
        
        
        //创建文字Lable
        UILabel *Lable = [[UILabel alloc] init ];
        Lable.text = @"高仿百思不得姐,你无法登陆\n过把瘾儿就算了吧~\n 欧耶~~~!";
        Lable.font = [UIFont fontWithName:nil size:18];
        Lable.numberOfLines = 0;
        Lable.textColor = [UIColor grayColor];
        [self addSubview:Lable];
        //设置文字居中显示
        [Lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.center);
        }];
        
        //创建头像Icon
        UIImageView *Icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_cry_icon"]];
        [self addSubview:Icon];
        
        //设置头像frame
        [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(Lable.mas_centerY).offset(-80);
        }];
        
        
        //创建登录按钮
        UIButton *Login = [[UIButton alloc] init];
        [Login setTitle:@"立即登录注册" forState:UIControlStateNormal];
        [Login setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
        [Login setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
        [Login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [Login setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:Login];
        
        //设置按钮frame
        [Login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(200));
            make.height.equalTo(@(40));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(Lable.mas_centerY).offset(100);
            
        }];
    }
   
    return self;
}


@end
