//
//  UIBarButtonItem+RNExtension.m
//  百思不得姐
//
//  Created by rain on 16/10/1.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "UIBarButtonItem+RNExtension.h"

@implementation UIBarButtonItem (RNExtension)

+(instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage addTarget:(id)target action:(SEL)action
{
    //创建左边item按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    //设置左边按钮frame
    CGFloat width = button.currentBackgroundImage.size.width;
    CGFloat height = button.currentBackgroundImage.size.height;
    button.frame = CGRectMake(0, 0, width, height);
    //    leftBtn.frame.size = CGSizeMake(width, height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //返回自定义item
    return [[self alloc] initWithCustomView:button];
}

@end
