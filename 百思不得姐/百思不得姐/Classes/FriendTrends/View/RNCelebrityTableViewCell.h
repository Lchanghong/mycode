//
//  RNCelebrityTableViewCell.h
//  百思不得姐
//
//  Created by rain on 16/10/4.
//  Copyright © 2016年 rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RNUsers;
@interface RNCelebrityTableViewCell : UITableViewCell

/***用户模型***/
@property (strong, nonatomic) RNUsers *user;
@end
