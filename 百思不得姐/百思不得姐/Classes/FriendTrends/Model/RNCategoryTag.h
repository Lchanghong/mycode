//
//  RNCategoryTag.h
//  百思不得姐
//
//  Created by rain on 16/10/2.
//  Copyright © 2016年 rain. All rights reserved.
//  左边推荐标签

#import <Foundation/Foundation.h>

@interface RNCategoryTag : NSObject
/***名字***/
@property (copy, nonatomic) NSString *name;
/***总数***/
@property (assign, nonatomic) NSInteger count;
/***ID***/
@property (assign, nonatomic) NSInteger id;

@end
