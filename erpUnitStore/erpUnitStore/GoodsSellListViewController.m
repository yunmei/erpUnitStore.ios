//
//  GoodsSellListViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "GoodsSellListViewController.h"
#import "GoodssellCell.h"
@interface GoodsSellListViewController ()

@end

@implementation GoodsSellListViewController
@synthesize goodsSellInformationArray = _goodsSellInformationArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.navigationItem.title = @"商品销售统计列表";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)goodsSellInformationArray
{
    if(_goodsSellInformationArray == nil)
    {
        _goodsSellInformationArray = [[NSMutableArray alloc]init];
    }
    return _goodsSellInformationArray;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.goodsSellInformationArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    GoodssellCell *cell = (GoodssellCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        UIButton *cellborder = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellborder setFrame:CGRectMake(1, 1, 318, 58)];
        cellborder.layer.cornerRadius = 5.0;
        cellborder.layer.borderWidth = 1.0;
        cellborder.layer.borderColor = [YMUIButton CreateCGColorRef:255.0 greenNumber:255.0 blueNumber:255.0 alphaNumber:1.0];
        [cellborder setBackgroundColor:[UIColor clearColor]];
        cell = [[GoodssellCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell addSubview:cellborder];
        [cell addSubview:cell.nameLable];
        [cell addSubview:cell.numberLable];
        [cell addSubview:cell.timeLable];
    }
    NSMutableDictionary *goodsSellInformationDictionary = [self.goodsSellInformationArray objectAtIndex:indexPath.row];
    [cell.nameLable setText:[goodsSellInformationDictionary objectForKey:@"Goods_Name"]];
    [cell.numberLable setText:[NSString stringWithFormat:@"销售数量: %@",[goodsSellInformationDictionary objectForKey:@"Sales_Amount"]]];
    [cell.timeLable setText:[NSString stringWithFormat:@"合计: %@",[goodsSellInformationDictionary objectForKey:@"Sales_Money"]]];
    return cell;
}

@end
