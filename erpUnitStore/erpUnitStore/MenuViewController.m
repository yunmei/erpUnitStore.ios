//
//  MenuViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-23.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "MenuViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//销售管理
- (IBAction)xsManage:(id)sender {
}

//采购管理
- (IBAction)cgManage:(id)sender {
}

//库存管理
- (IBAction)kcManage:(id)sender {
}

//应付账款
- (IBAction)payBill:(id)sender {
}

//应收账款
- (IBAction)getBill:(id)sender {
}

//供应商管理
- (IBAction)suppliersManage:(id)sender {
}

//会员管理
- (IBAction)memberMange:(id)sender {
}

//员工管理
- (IBAction)staffManage:(id)sender {
}

//关于
- (IBAction)about:(id)sender {
}
//消息
- (IBAction)message:(id)sender {
}
//设置
- (IBAction)site:(id)sender {
}
//退出
- (IBAction)logout:(id)sender {
}


@end
