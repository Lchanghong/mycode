//
//  RNUsers.h
//  百思不得姐
//
//  Created by rain on 2016/10/6.
//  Copyright © 2016年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNUsers : NSObject
/***头像***/
@property (copy, nonatomic) NSString *header;
/***是否VIP***/
@property (assign, nonatomic) BOOL is_vip;
/***粉丝***/
@property (assign, nonatomic) NSInteger fans_count;
/***昵称***/
@property (copy, nonatomic) NSString *screen_name;

@end
