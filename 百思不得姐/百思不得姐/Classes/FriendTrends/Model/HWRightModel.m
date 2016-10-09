//
//  HWRightModel.m
//  百思不得姐
//
//  Created by rain on 2016/10/9.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "HWRightModel.h"

@implementation HWRightModel

-(NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
