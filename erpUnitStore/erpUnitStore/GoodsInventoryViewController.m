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
@synthesize catButton = _catButton;
@synthesize allButton = _allButton;
@synthesize inventoryButton = _inventoryButton;
@synthesize alarmButton = _alarmButton;
@synthesize catView = _catView;
@synthesize backgroundView = _backgroundView;
@synthesize firstCatTableView = _firstCatTableView;
@synthesize secondCatTableView = _secondCatTableView;
@synthesize firstCatArray;
@synthesize secondCatArray;
@synthesize selectedCatId;
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
    [self.view addSubview:self.backgroundView];
    //获得系统时间
    [self.inventoryTableView setBackgroundColor:[UIColor blackColor]];
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"MM"];
//    self.monthString = [dateformatter stringFromDate:senddate];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH-mm-ss"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
//    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
//    [headerView setBackgroundColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]];
//    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 250, 15)];
//    [timeLable setText:[NSString stringWithFormat:@"截至日期:%@",locationString]];
//    [timeLable setFont:[UIFont systemFontOfSize:12.0]];
//    [timeLable setTextColor:[UIColor whiteColor]];
//    [timeLable setBackgroundColor:[UIColor clearColor]];
//    [headerView addSubview:timeLable];
//    [self.view addSubview:headerView];
    //加入顶部的导航button条
    self.catButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.catButton setFrame:CGRectMake(18, 4, 70, 30)];
    [self.catButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [self.catButton addTarget:self action:@selector(catPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.catButton setTitle:@"分类" forState:UIControlStateNormal];
    self.catButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.catButton.tag = 21;
    [self.view addSubview:self.catButton];
    
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allButton setFrame:CGRectMake(88, 4, 70, 30)];
    [self.allButton setBackgroundImage:[UIImage imageNamed:@"list_filter_focus.png"] forState:UIControlStateNormal];
    [self.allButton addTarget:self action:@selector(catPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.allButton setTitle:@"全部" forState:UIControlStateNormal];
    self.allButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.allButton setTag:22];
    [self.view addSubview:self.allButton];
    
    self.inventoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.inventoryButton setFrame:CGRectMake(158, 4, 70, 30)];
    [self.inventoryButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [self.inventoryButton addTarget:self action:@selector(catPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.inventoryButton setTitle:@"库存量" forState:UIControlStateNormal];
     self.inventoryButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.inventoryButton setTag:23];
    [self.view addSubview:self.inventoryButton];
    
    self.alarmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alarmButton setFrame:CGRectMake(228, 4, 70, 30)];
    [self.alarmButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [self.alarmButton addTarget:self action:@selector(catPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.alarmButton setTitle:@"报警" forState:UIControlStateNormal];
    self.alarmButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.alarmButton setTag:24];
    [self.view addSubview:self.alarmButton];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 0)
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
    }else if (tableView.tag ==1){
        self.selectedCatId = [[self.firstCatArray objectAtIndex:indexPath.row] objectForKey:@"Type_ID"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MKNetworkEngine *engine = [YMGlobal getEngine];
        MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
        // op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":100,\\\"sort\\\":1,\\\"typeid\\\":\\\"\\\"" execOp:op];
        NSString *apiparamString = [NSString stringWithFormat:@"\\\"typeid\\\":\\\"%@\\\"",self.selectedCatId];
        op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:apiparamString execOp:op];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
            [hud hide:YES];
            if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
            {
                self.secondCatArray = [parser objectWithString:[data objectForKey:@"body"]];
                [self.catView addSubview:self.secondCatTableView];
                [self.secondCatTableView reloadData];
            }
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [hud hide:YES];
            NSLog(@"error%@",[completedOperation responseString]);
        }];
        [engine enqueueOperation:op];
    }else{
        self.selectedCatId = [[self.secondCatArray objectAtIndex:indexPath.row] objectForKey:@"Type_ID"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MKNetworkEngine *engine = [YMGlobal getEngine];
        MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
          NSString *apiparamString = [NSString stringWithFormat:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":100,\\\"sort\\\":1,\\\"typeid\\\":\\\"%@\\\"",self.selectedCatId];
         op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:apiparamString execOp:op];
        //op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:apiparamString execOp:op];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
           // NSLog(@"responseString%@",[completedOperation responseString]);
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
            NSLog(@"data%@",[data objectForKey:@"body"]);
            [hud hide:YES];
            if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
            {
                if([data objectForKey:@"body"] == [NSNull null])
                {
                    [self slideBack];
                }else{
                    self.goodsInventoryArray = [parser objectWithString:[data objectForKey:@"body"]];
                    [self.inventoryTableView reloadData];
                    [self slideBack];
                }
            }
           // NSLog(@"class%@",[[data objectForKey:@"body"] class]);
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [hud hide:YES];
            NSLog(@"error%@",[completedOperation responseString]);
        }];
        [engine enqueueOperation:op];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 0)
    {
        return 50;
    }else if (tableView.tag ==1){
        return 30;
    }else{
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 0)
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
        cell.percentbarButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.percentbarButton setFrame:CGRectMake(10, 27, 300*i, 15)];
        return cell;
    }else if (tableView.tag ==1){
        static NSString *identifier = @"firstCatCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        cell.textLabel.text = [[self.firstCatArray objectAtIndex:indexPath.row] objectForKey:@"Type_Name"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return  cell;
    
    }else{
        static NSString *identifier = @"secondCatCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.text = [[self.secondCatArray objectAtIndex:indexPath.row] objectForKey:@"Type_Name"];
        return  cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(tableView.tag == 0)
    {
        return [self.goodsInventoryArray count];
    }else if (tableView.tag == 1){
        if(self.firstCatArray){
            return [self.firstCatArray count];
        }else{
            return 0;
        }
    }else{
        if(self.secondCatArray){
            return [self.secondCatArray count];
        }else{
            return 0;
        }
    }
}

//当视图拖动的时候
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.inventoryTableView tableViewDidDragging];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int state = 0;
    //int countPage = 0;
    state = [self.inventoryTableView tableViewDidEndDragging];
    if(state == k_RETURN_LOADMORE)
    {
        
    }else if (state == k_RETURN_REFRESH){
        
    }
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

-(PullToRefreshTableView *)inventoryTableView
{
    if(_inventoryTableView == nil)
    {
        _inventoryTableView = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 40, 320, [UIScreen mainScreen].bounds.size.height-94)];
    }
    _inventoryTableView.tag = 0;
    _inventoryTableView.dataSource = self;
    _inventoryTableView.delegate = self;
    _inventoryTableView.separatorColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    return _inventoryTableView;
}
-(UITableView *)firstCatTableView
{
    if(_firstCatTableView == nil)
    {
        _firstCatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 140, 280)];
        _firstCatTableView.tag = 1;
        _firstCatTableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
        _firstCatTableView.showsVerticalScrollIndicator = NO;
        _firstCatTableView.delegate = self;
        _firstCatTableView.dataSource = self;
        _firstCatTableView.separatorColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    }
    return _firstCatTableView;
}

-(UITableView *)secondCatTableView
{
    if(_secondCatTableView == nil)
    {
        _secondCatTableView = [[UITableView alloc]initWithFrame:CGRectMake(140, 0, 140, 280)];
        _secondCatTableView.tag = 2;
        _secondCatTableView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
        _secondCatTableView.delegate = self;
        _secondCatTableView.dataSource = self;
        _secondCatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _secondCatTableView;
}

- (void)backVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)changetoolBarBackground:(UIButton *)button
{
    [self.catButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [self.allButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [self.inventoryButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [self.alarmButton setBackgroundImage:[UIImage imageNamed:@"list_filter.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"list_filter_focus.png"] forState:UIControlStateNormal];
}

-(void)catPressed:(id)sender
{
    UIButton *pressedButton = sender;
    [self changetoolBarBackground:pressedButton];
    if(pressedButton.tag == 21)
    {
        if(self.catView.frame.size.height>0)
        {
            [self.backgroundView setFrame:CGRectMake(0, 0, 320, 0)];

            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:0.3];
            [self.catView setFrame:CGRectMake(18, 34, 280, 0)];
            // UIView *catView = [[UIView alloc]initWithFrame:CGRectMake(18, 34, 280, 350)];
            [UIView commitAnimations];
            [self.firstCatTableView removeFromSuperview];
            [self.secondCatTableView removeFromSuperview];
        }else{
            CGSize size = [UIScreen mainScreen].bounds.size;
            [self.view addSubview:self.catView];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:0.3];
            [self.catView setFrame:CGRectMake(18, 34, 280, 280)];
            // UIView *catView = [[UIView alloc]initWithFrame:CGRectMake(18, 34, 280, 350)];
            [UIView commitAnimations];
            [self.backgroundView setFrame:CGRectMake(0, 0, 320, size.height)];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            MKNetworkEngine *engine = [YMGlobal getEngine];
            MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
           // op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":100,\\\"sort\\\":1,\\\"typeid\\\":\\\"\\\"" execOp:op];
            op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:@"" execOp:op];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
                [hud hide:YES];
                if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
                {
                    self.firstCatArray = [parser objectWithString:[data objectForKey:@"body"]];
                   // NSLog(@"111%@",self.firstCatArray);
                    [self.firstCatTableView reloadData];
                }
                
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                [hud hide:YES];
                NSLog(@"error%@",[completedOperation responseString]);
            }];
            [engine enqueueOperation:op];

        }
        
    }else if (pressedButton.tag == 22){
        MKNetworkEngine *engine = [YMGlobal getEngine];
        MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
        op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":100,\\\"sort\\\":1,\\\"typeid\\\":\\\"\\\"" execOp:op];
        // op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:@"" execOp:op];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
            if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
            {
                NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
                self.goodsInventoryArray = bodyArray;
                [self.inventoryTableView reloadData];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"error%@",[completedOperation responseString]);
        }];
        [engine enqueueOperation:op];
    }else if (pressedButton.tag == 23){
        MKNetworkEngine *engine = [YMGlobal getEngine];
        MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
        op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":100,\\\"sort\\\":1,\\\"typeid\\\":\\\"\\\"" execOp:op];
        // op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:@"" execOp:op];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
            if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
            {
                NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
                self.goodsInventoryArray = bodyArray;
                [self.inventoryTableView reloadData];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"error%@",[completedOperation responseString]);
        }];
        [engine enqueueOperation:op];
    }else if(pressedButton.tag == 24){
        MKNetworkEngine *engine = [YMGlobal getEngine];
        MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
        op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":100,\\\"sort\\\":1,\\\"typeid\\\":\\\"\\\",\\\"warning\\\":\\\"1\\\"" execOp:op];
        // op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:@"" execOp:op];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
            if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
            {
                NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
                self.goodsInventoryArray = bodyArray;
                [self.inventoryTableView reloadData];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"error%@",[completedOperation responseString]);
        }];
        [engine enqueueOperation:op];
    }
}

-(UIView *)catView
{
    if(_catView ==nil)
    {
        _catView = [[UIView alloc]initWithFrame:CGRectMake(18, 43, 280, 0)];
        [_catView setBackgroundColor:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0]];
    }
    [_catView addSubview:self.firstCatTableView];
    //[_catView addSubview:self.secondCatTableView];
    return _catView;
}

-(UIView *)backgroundView
{
    //CGSize size = [UIScreen mainScreen].bounds.size;
    if(_backgroundView ==nil)
    {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
        [_backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        UITapGestureRecognizer *tapGresture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBack:)];
        [_backgroundView addGestureRecognizer:tapGresture];
    }
    return _backgroundView;
}

-(void)tapBack:(id)sender
{
    return;
}

-(void)slideBack
{
    [self.backgroundView setFrame:CGRectMake(0, 0, 320, 0)];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    [self.catView setFrame:CGRectMake(18, 34, 280, 0)];
    // UIView *catView = [[UIView alloc]initWithFrame:CGRectMake(18, 34, 280, 350)];
    [UIView commitAnimations];
    [self.firstCatTableView removeFromSuperview];
    [self.secondCatTableView removeFromSuperview];
}
@end
