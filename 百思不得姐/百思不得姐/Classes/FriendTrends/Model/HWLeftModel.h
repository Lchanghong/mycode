//
//  HWLeftModel.h
//  百思不得姐
//
//  Created by rain on 2016/10/9.
//  Copyright © 2016年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWRightModel.h"

@interface HWLeftModel : NSObject

/***ID***/
@property (assign, nonatomic) NSInteger ID;

/***名字***/
@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) HWRightModel *rightModel;

@end
