//
//  SuppliersListViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SuppliersListViewController.h"
#import "GoodssellCell.h"
#import "SupplierInformationViewController.h"
@interface SuppliersListViewController ()

@end

@implementation SuppliersListViewController
@synthesize supplierListArray = _supplierListArray;
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
    self.navigationItem.title = @"供应商列表";
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backVC:)];
      self.navigationItem.leftBarButtonItem = backItem;
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)supplierListArray
{
    if(_supplierListArray == nil)
    {
        _supplierListArray = [[NSMutableArray alloc]init];
    }
    return _supplierListArray;
}

- (void)backVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.supplierListArray count];
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
        cellborder.enabled = NO;
        cellborder.layer.borderColor = [YMUIButton CreateCGColorRef:255.0 greenNumber:255.0 blueNumber:255.0 alphaNumber:1.0];
        [cellborder setBackgroundColor:[UIColor clearColor]];
        cell = [[GoodssellCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell addSubview:cellborder];
        [cell.numberLable setFrame:CGRectMake(10, 30, 300, 20)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:cell.nameLable];
        [cell addSubview:cell.numberLable];
        [cell addSubview: cell.timeLable];
    }
    NSMutableDictionary *supplierInformationDictionary = [self.supplierListArray objectAtIndex:indexPath.row];
    [cell.nameLable setText:[supplierInformationDictionary objectForKey:@"Provider_name"]];
    [cell.numberLable setText:[NSString stringWithFormat:@"地址:%@",[supplierInformationDictionary objectForKey:@"Provider_name"]]];
    //[cell.nameLable setText:[supplierInformationDictionary objectForKey:@"Provider_name"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *supplierInformationDictionary = [self.supplierListArray objectAtIndex:indexPath.row];
    NSString *supplierId = [supplierInformationDictionary objectForKey:@"Provider_id"];
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    NSString *apiparam = [NSString stringWithFormat:@"\\\"provider_id\\\":\\\"%@\\\"",supplierId];
    op = [YMGlobal setOperationParams:@"Get.SingleProvider" apiparam:apiparam execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableDictionary *bodyDic = [parser objectWithString:[data objectForKey:@"body"]];
            SupplierInformationViewController *supplierInformationVC = [[SupplierInformationViewController alloc]init];
            supplierInformationVC.supplierDictionary = bodyDic;
            [self.navigationController pushViewController:supplierInformationVC animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}
@end
