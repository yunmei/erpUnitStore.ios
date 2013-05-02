//
//  GoodssellCell.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "GoodssellCell.h"

@implementation GoodssellCell

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

- (UILabel *)nameLable
{
    if(_nameLable == nil)
    {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 20)];
        [_nameLable setBackgroundColor:[UIColor clearColor]];
        [_nameLable setFont:[UIFont systemFontOfSize:15.0]];
        [_nameLable setTextColor:[UIColor colorWithRed:255/255 green:227/255.0 blue:129/255.0 alpha:1.0]];
    }
    return _nameLable;
}

- (UILabel *)numberLable
{
    if(_numberLable == nil)
    {
        _numberLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 80, 20)];
        [_numberLable setBackgroundColor:[UIColor clearColor]];
        [_numberLable setFont:[UIFont systemFontOfSize:13.0]];
        [_numberLable setTextColor:[UIColor colorWithRed:255/255 green:227/255.0 blue:129/255.0 alpha:1.0]];
    }
    return _numberLable;
}
- (UILabel *)timeLable
{
    if(_timeLable == nil)
    {
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 200, 20)];
        [_timeLable setBackgroundColor:[UIColor clearColor]];
        [_timeLable setFont:[UIFont systemFontOfSize:12.0]];
        [_timeLable setTextColor:[UIColor colorWithRed:255/255 green:227/255.0 blue:129/255.0 alpha:0.7]];
    }
    return _timeLable;
}
@end
