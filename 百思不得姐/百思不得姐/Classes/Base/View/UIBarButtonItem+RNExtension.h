//
//  UIBarButtonItem+RNExtension.h
//  百思不得姐
//
//  Created by rain on 16/10/1.
//  Copyright © 2016年 rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RNExtension)
//创建item类方法
+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage addTarget:(id)target action:(SEL)action
 ;

@end
