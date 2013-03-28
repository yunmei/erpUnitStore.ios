//
//  LibraryCell.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "LibraryCell.h"

@implementation LibraryCell
@synthesize nameLable = _nameLable;
@synthesize numberLable = _numberLable;
@synthesize timeLable = _timeLable;
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
        [_nameLable setTextColor:[UIColor whiteColor]];
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
        [_numberLable setTextColor:[UIColor whiteColor]];
    }
    return _numberLable;
}
- (UILabel *)timeLable
{
    if(_timeLable == nil)
    {
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 20)];
        [_timeLable setBackgroundColor:[UIColor clearColor]];
        [_timeLable setFont:[UIFont systemFontOfSize:12.0]];
        [_timeLable setTextColor:[UIColor whiteColor]];
    }
    return _timeLable;
}

@end
