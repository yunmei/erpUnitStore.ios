//
//  MenuViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-23.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "MenuViewController.h"
#import "GoodsInventoryViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "MonitorViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relogin:) name:@"INeedToLogin1" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//销售管理
- (IBAction)xsManage:(id)sender {
    
     SellChartViewController *sellChartVC = [[SellChartViewController alloc]init];
    UINavigationController *sellNavigation = [[UINavigationController alloc]initWithRootViewController:sellChartVC];
    [self presentViewController:sellNavigation animated:YES completion:nil];
    
}

//采购管理
- (IBAction)cgManage:(id)sender {
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    op = [YMGlobal setOperationParams:@"Get.Library_Statistical" apiparam:@"\\\"wherestr\\\":\\\"\\\"" execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"completedOperation%@",[completedOperation responseString]);
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            LibraryViewController *libraryVC = [[LibraryViewController alloc]init];
            UINavigationController *libraryNavigation = [[UINavigationController alloc]initWithRootViewController:libraryVC];
            libraryVC.libraryArray = bodyArray;
            [self presentViewController:libraryNavigation animated:YES completion:nil];
//            GoodsInventoryViewController *goodsInventoryVC = [[GoodsInventoryViewController alloc]init];
//            goodsInventoryVC.goodsInventoryArray = bodyArray;
//            UINavigationController *inventoryNavigation = [[UINavigationController alloc]initWithRootViewController:goodsInventoryVC];
//            [self presentViewController:inventoryNavigation animated:YES completion:nil];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
    
}

//库存管理
- (IBAction)kcManage:(id)sender {
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    op = [YMGlobal setOperationParams:@"Get.InventoryList" apiparam:@"\\\"wherestr\\\":\\\"\\\",\\\"pageindex\\\":1,\\\"pagesize\\\":9,\\\"sort\\\":1,\\\"typeid\\\":\\\"\\\"" execOp:op];
     // op = [YMGlobal setOperationParams:@"Get.CategoryGoodsList" apiparam:@"" execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",[completedOperation responseString]);
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
       if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
       {
           NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
           GoodsInventoryViewController *goodsInventoryVC = [[GoodsInventoryViewController alloc]init];
           goodsInventoryVC.goodsInventoryArray = bodyArray;
            UINavigationController *inventoryNavigation = [[UINavigationController alloc]initWithRootViewController:goodsInventoryVC];
           [self presentViewController:inventoryNavigation animated:YES completion:nil];
       }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}

//供应商管理
- (IBAction)payBill:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    op = [YMGlobal setOperationParams:@"Get.AllProviders" apiparam:@"\\\"shop_id\\\":\\\"\\\"" execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJson_Parser *parser = [[SBJson_Parser alloc]init];
        NSLog(@"com%@",[completedOperation responseString]);
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        [hud hide:YES];
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
            NSMutableArray *bodyArray = [parser objectWithString:[data objectForKey:@"body"]];
            SuppliersListViewController *supplierListVC = [[SuppliersListViewController alloc]init];
            supplierListVC.supplierListArray = bodyArray;
            UINavigationController *supplierNavigation = [[UINavigationController alloc]initWithRootViewController:supplierListVC];
            [self presentViewController:supplierNavigation animated:YES completion:nil];
//            GoodsInventoryViewController *goodsInventoryVC = [[GoodsInventoryViewController alloc]init];
//            goodsInventoryVC.goodsInventoryArray = bodyArray;
//            UINavigationController *inventoryNavigation = [[UINavigationController alloc]initWithRootViewController:goodsInventoryVC];
//            [self presentViewController:inventoryNavigation animated:YES completion:nil];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [hud hide:YES];
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}

//应收账款
- (IBAction)getBill:(id)sender {
}

//应付账款
- (IBAction)suppliersManage:(id)sender {
   MonitorViewController *monitorVC = [[MonitorViewController alloc]init];
    [self presentViewController:monitorVC animated:YES completion:nil];
}

//会员管理
- (IBAction)memberMange:(id)sender {
}

//员工管理
- (IBAction)staffManage:(id)sender {
}

//关于
- (IBAction)about:(id)sender {
    AboutUsViewController *aboutVC = [[AboutUsViewController alloc]init];
    UINavigationController *aboutNavigation = [[UINavigationController alloc]initWithRootViewController:aboutVC];
    [self presentViewController:aboutNavigation animated:YES completion:nil];
}
//消息
- (IBAction)message:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您目前没有收到任何消息!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//设置
- (IBAction)site:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    UINavigationController *settingNavigation = [[UINavigationController alloc]initWithRootViewController:settingVC];
    [self presentViewController:settingNavigation animated:YES completion:nil];
}
//退出
- (IBAction)logout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)relogin:(NSNotification *)note
{
    NSLog(@"222");
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
