//
//  GoodsInvestoryCell.m
//  erpUnitStore
//
//  Created by ken on 13-3-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "GoodsInvestoryCell.h"

@implementation GoodsInvestoryCell
@synthesize goodsNameLable = _goodsNameLable;
@synthesize invertoryLable = _invertoryLable;
@synthesize percentbarButton = _percentbarButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)goodsNameLable
{
    if(_goodsNameLable == nil)
    {
        _goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 20)];
        [_goodsNameLable setBackgroundColor:[UIColor clearColor]];
        [_goodsNameLable setTextColor:[UIColor colorWithRed:255/255 green:227/255.0 blue:129/255.0 alpha:1.0]];
        [_goodsNameLable setFont:[UIFont systemFontOfSize:14.0]];
    }
    
    return _goodsNameLable;
}

- (UILabel *)invertoryLable
{
    if(_invertoryLable == nil)
    {
        _invertoryLable = [[UILabel alloc]initWithFrame:CGRectMake(230, 5, 70, 20)];
        [_invertoryLable setBackgroundColor:[UIColor clearColor]];
        [_invertoryLable setTextColor:[UIColor colorWithRed:255/255 green:227/255.0 blue:129/255.0 alpha:0.3]];
        [_invertoryLable setFont:[UIFont systemFontOfSize:14.0]];
    }
    return _invertoryLable;
}

- (UIButton *)percentbarButton
{
    if(_percentbarButton == nil)
    {
        _percentbarButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 27, 300, 15)];
        _percentbarButton.layer.cornerRadius = 4.0;
        _percentbarButton.layer.borderWidth = 0.2;
        _percentbarButton.layer.shadowOffset= CGSizeMake(1, 1);
        _percentbarButton.layer.shadowRadius= 3.0;
        _percentbarButton.layer.shadowColor= [UIColor whiteColor].CGColor;
        _percentbarButton.layer.shadowOpacity= 1.0;
        _percentbarButton.layer.borderColor= [UIColor whiteColor].CGColor;
        //._percentbarButto
    }
    return _percentbarButton;
}
@end
