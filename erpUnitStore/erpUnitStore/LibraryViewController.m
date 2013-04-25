//
//  LibraryViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "LibraryViewController.h"
#import "LibraryInformationController.h"
@interface LibraryViewController ()

@end

@implementation LibraryViewController
@synthesize libraryArray = _libraryArray;
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
    // Do any additional setup after loading the view from its nib.    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.navigationItem.title = @"入库统计";
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backVC:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.libraryArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    LibraryCell *cell = (LibraryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        UIButton *cellborder = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellborder setFrame:CGRectMake(1, 1, 318, 58)];
        cellborder.layer.cornerRadius = 5.0;
        cellborder.layer.borderWidth = 1.0;
        cellborder.layer.borderColor = [YMUIButton CreateCGColorRef:255.0 greenNumber:255.0 blueNumber:255.0 alphaNumber:1.0];
        [cellborder setBackgroundColor:[UIColor clearColor]];
        cellborder.enabled = NO;
        cell = [[LibraryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:cellborder];
        [cell addSubview:cell.nameLable];
        [cell addSubview:cell.timeLable];
        [cell addSubview:cell.numberLable];
    }
    NSMutableDictionary *goodsInfo = [self.libraryArray objectAtIndex:indexPath.row];
    cell.nameLable.text = [goodsInfo objectForKey:@"Goods_Name"];
    cell.timeLable.text = [NSString stringWithFormat:@"入库时间:%@",[goodsInfo objectForKey:@"Operator_Date"]];
    cell.numberLable.text = [NSString stringWithFormat:@"数量:%@",[goodsInfo objectForKey:@"Amount"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryInformationController *libraryInfoVC = [[LibraryInformationController alloc]init];
    libraryInfoVC.libraryInfoDictionary = [self.libraryArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:libraryInfoVC animated:YES];
}

- (NSMutableArray *)libraryArray
{
    if(_libraryArray == nil)
    {
        _libraryArray = [[NSMutableArray alloc]init];
    }
    return _libraryArray;
}

- (void)backVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
