//
//  RNTabBar.m
//  百思不得姐
//
//  Created by rain on 16/9/30.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNTabBar.h"

@interface RNTabBar ()
/***发布按钮***/
@property(nonatomic, weak) UIButton *publishButton;

@end

@implementation RNTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置publish按钮的frame
    CGFloat width = self.publishButton.currentBackgroundImage.size.width;
    CGFloat height = self.publishButton.currentBackgroundImage.size.height;
    
    self.publishButton.frame = CGRectMake(0, 0, width, height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    //重新布局tabBar
    
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        if (index == 2) {  index += 1; }
        
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //创建publish按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮背景图片
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    
        //添加按钮到tabBar
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
    }

    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
