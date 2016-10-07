//
//  RNCelebrityTableViewCell.m
//  百思不得姐
//
//  Created by rain on 16/10/4.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNCelebrityTableViewCell.h"
#import "RNUsers.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
@interface RNCelebrityTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *VIPImageView;
@property (weak, nonatomic) IBOutlet UILabel *fansLable;

@end

@implementation RNCelebrityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(RNUsers *)user
{
    _user = user;
    
    [_VIPImageView setImage:[UIImage sd_animatedGIFNamed:@"member_ diamond_icon"]];
    _screenNameLable.text = user.screen_name;
    _fansLable.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _headerImageView.layer.cornerRadius = 50.0 * 0.5;
    _headerImageView.layer.masksToBounds = YES;
    
    if (user.is_vip) {
        _screenNameLable.textColor = [UIColor redColor];
        _VIPImageView.hidden = NO;
    }else{
        _screenNameLable.textColor = [UIColor blackColor];
        _VIPImageView.hidden = YES;
    }
}
@end
