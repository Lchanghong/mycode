//
//  RNCategoryTagCell.m
//  百思不得姐
//
//  Created by rain on 16/10/2.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNCategoryTagCell.h"
//#import "RNCategoryTag.h"

@interface RNCategoryTagCell ()
//左边选中指示条
@property (weak, nonatomic) UIView *SelectView;

@end
@implementation RNCategoryTagCell

- (void)setModel:(HWLeftModel *)model
{
    self.textLabel.text = model.name;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //创建选中指示器
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 5, self.frame.size.height);
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        self.SelectView = view;
    }
    
     return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
    self.SelectView.hidden = !selected;
    
    UIView *View = [[UIView alloc] init ];
    View.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = View;;
}

@end
