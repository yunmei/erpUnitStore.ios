//
//  GoodsInventoryViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "GoodsInventoryViewController.h"
#import "GoodsInvestoryCell.h"
#import "GoodsInformationViewController.h"
@interface GoodsInventoryViewController ()

@end

@implementation GoodsInventoryViewController
@synthesize goodsInventoryArray = _goodsInventoryArray;;
@synthesize inventoryTableView = _inventoryTableView;
@synthesize monthString;
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
    self.navigationItem.title = @"库存统计";
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backVC:)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.view addSubview:self.inventoryTableView];
    NSLog(@"goodsInventoryArray%@",self.goodsInventoryArray);
    //获得系统时间
    [self.inventoryTableView setBackgroundColor:[UIColor blackColor]];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM"];
    self.monthString = [dateformatter stringFromDate:senddate];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH-mm-ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]];
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 250, 15)];
    [timeLable setText:[NSString stringWithFormat:@"截至日期:%@",locationString]];
    [timeLable setFont:[UIFont systemFontOfSize:12.0]];
    [timeLable setTextColor:[UIColor whiteColor]];
    [timeLable setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:timeLable];
    [self.view addSubview:headerView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //格式化时间
    NSTimeInterval secondsPerDay = 26*60*60;
    NSDate *senddatebefor30 = [[NSDate alloc]initWithTimeIntervalSinceNow:-secondsPerDay*30];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSString *  locationBefore30String = [dateformatter stringFromDate:senddatebefor30];
    NSString *dateAppend = [NSString stringWithFormat:@"%@|%@",locationBefore30String,locationString];
    
    NSString *goodsId = [[self.goodsInventoryArray objectAtIndex:indexPath.row] objectForKey:@"Goods_ID"];
    MBProgressHUD *hud = [MBProgressHUD  showHUDAddedTo:self.navigationController.view animated:YES];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]]];
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    NSString *apiparamString = [NSString stringWithFormat:@"\\\"Goods_id\\\":\\\"%@\\\",\\\"date_range\\\":\\\"%@\\\",\\\"ordertype\\\":\\\"Sell\\\"",goodsId,dateAppend];
    op = [YMGlobal setOperationParams:@"Get.SingleGoodsSalesGroup" apiparam:apiparamString execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",[completedOperation responseString]);
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
             GoodsInformationViewController *goodsInfoVC = [[GoodsInformationViewController alloc]init];
             goodsInfoVC.goodsId = goodsId;
            goodsInfoVC.monthString = self.monthString;
             UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
              self.navigationItem.backBarButtonItem = backItem;
               [self.navigationController pushViewController:goodsInfoVC animated:YES];
        }
        [hud hide:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [hud hide:YES];
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *identifier = @"inventorycell";
    GoodsInvestoryCell *cell = (GoodsInvestoryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[GoodsInvestoryCell alloc]init];
        [cell addSubview:cell.goodsNameLable];
        [cell addSubview:cell.invertoryLable];
        [cell addSubview:cell.percentbarButton];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableDictionary *singleGoodsData = [self.goodsInventoryArray objectAtIndex:indexPath.row];
    float i = [[singleGoodsData objectForKey:@"Stock_Amount"] floatValue]/[[singleGoodsData objectForKey:@"All_Amount"] floatValue];
    [cell.goodsNameLable setText:[NSString stringWithFormat:@"%@",[singleGoodsData objectForKey:@"Goods_Name"]]];
    [cell.invertoryLable setText:[NSString stringWithFormat:@"库存量:%@",[singleGoodsData objectForKey:@"Stock_Amount"]]];
    if(i > 0.7)
    {
        [cell.percentbarButton setBackgroundColor:[UIColor colorWithRed:117/255.0 green:159/255.0 blue:49/255.0 alpha:1.0]];
    }else if (i > 0.5)
    {
         [cell.percentbarButton setBackgroundColor:[UIColor colorWithRed:56/255.0 green:132/255.0 blue:191/255.0 alpha:1.0]];
    }else{
        [cell.percentbarButton setBackgroundColor:[UIColor colorWithRed:212/255.0 green:101/255.0 blue:50/255.0 alpha:1.0]];
    }
    [cell.percentbarButton setTitle:[NSString stringWithFormat:@"%g%%",i*100] forState:UIControlStateNormal];
    cell.percentbarButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    cell.percentbarButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [cell.percentbarButton setFrame:CGRectMake(10, 27, 300*i, 15)];
    
return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.goodsInventoryArray count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)goodsInventoryArray
{
    if(_goodsInventoryArray == nil)
    {
        _goodsInventoryArray = [[NSMutableArray alloc]init];
    }
    return _goodsInventoryArray;
}

-(UITableView *)inventoryTableView
{
    if(_inventoryTableView == nil)
    {
        _inventoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 320, 400)];
    }
    _inventoryTableView.dataSource = self;
    _inventoryTableView.delegate = self;
    _inventoryTableView.separatorColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    return _inventoryTableView;
}

- (void)backVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
