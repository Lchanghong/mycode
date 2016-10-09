//
//  HWRightModel.h
//  百思不得姐
//
//  Created by rain on 2016/10/9.
//  Copyright © 2016年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWRightModel : NSObject

/***总数***/
@property (assign, nonatomic) NSInteger count;

/***Tag对应users的数据***/
@property (strong, nonatomic) NSMutableArray *users;

/***总数***/
@property (assign, nonatomic) NSInteger total;
/***总页数***/
@property (assign, nonatomic) NSInteger total_page;

@property (assign, nonatomic) NSInteger next_page;

/***当前页码***/
@property (assign, nonatomic) NSInteger currentPage;

@end
