//
//  SettingViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SettingViewController.h"
#import "HelpViewController.h"
#import "UserSurggestViewController.h"
#import "SetPasswordViewController.h"
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import <QuartzCore/QuartzCore.h>
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize backgroundView = _backgroundView;
@synthesize shoplistTableView = _shoplistTableView;
@synthesize shoplistArray;
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
    UITableView *mainView = (UITableView *)self.view;
    mainView.backgroundView = nil;
    mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relogin:) name:@"INeedToLogin" object:nil];
    [self.view addSubview:self.shoplistTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag == 1)
    {
        return 1;
    }else{
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag ==1)
    {
        return [self.shoplistArray count];
    }else{
        if(section ==0)
        {
            return 1;
        }else if (section ==1){
            return 3;
        }else if (section ==2){
            return 3;
        }else{
            return 1;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        return 40;
    }else{
        return 30;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == 0)
    {
        if(section == 0)
        {
            return @"官方网址";
        }else if (section ==1){
            return @"设置";
        }else if (section ==2){
            return @"帮助";
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 0)
    {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(indexPath.section == 0)
        {
            cell.textLabel.text = @"http://www.maimaicha.com";
        }else if (indexPath.section ==1){
            if(indexPath.row == 0){
                cell.textLabel.text = @"清空缓存";
            }else if(indexPath.row == 1){
                cell.textLabel.text = @"修改密码";
            }else{
                cell.textLabel.text = @"店铺切换";
            }
        }else if (indexPath.section ==2){
            if(indexPath.row == 0){
                cell.textLabel.text = @"帮助手册";
            }else if (indexPath.row ==1){
                cell.textLabel.text = @"检查更新";
            }else {
                cell.textLabel.text = @"意见反馈";
            }
        }else{
            cell.textLabel.text = @"客服电话 : 967067";
            [cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;

    }else{
        static NSString * identifier = @"shoplist";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = [[self.shoplistArray objectAtIndex:indexPath.row] objectForKey:@"Shop_Name"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        if(indexPath.row ==0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已清除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else if(indexPath.row == 1){
            SetPasswordViewController *setPassVC = [[SetPasswordViewController alloc]init];
            [self.navigationController pushViewController:setPassVC animated:YES];
        }else{
            [self.view addSubview:self.backgroundView];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            MKNetworkEngine *engine = [YMGlobal getEngine];
            MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
            NSString *apiparam = [NSString stringWithFormat:@""];
            op = [YMGlobal setOperationParams:@"Get.ShopList" apiparam:apiparam execOp:op];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                NSLog(@"completed%@",[completedOperation responseString]);
                SBJson_Parser *parser = [[SBJson_Parser alloc]init];
                NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
                if(!([data objectForKey:@"body"] == [NSNull null]))
                {
                    [self.view bringSubviewToFront:self.shoplistTableView];
                    self.shoplistArray = [parser objectWithString:[data objectForKey:@"body"]];
                    [self.shoplistTableView reloadData];
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                    [UIView setAnimationDuration:0.3];
                    int i = [self.shoplistArray count];
                    if(i>5)
                    {
                        i=5;
                    }
                    [self.shoplistTableView setFrame:CGRectMake(72, 190, 180, i*40)];
                    self.shoplistTableView.layer.borderWidth = 1;
                    [UIView commitAnimations];
                }
                [hud hide:YES];
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                [hud hide:YES];
                NSLog(@"error%@",[completedOperation responseString]);
            }];
            [engine enqueueOperation:op];

        }
    }else if (indexPath.section ==2){
        if(indexPath.row == 0)
        {
            HelpViewController *helplistView = [[HelpViewController alloc]init];
            helplistView.requestString = [[NSURL alloc]initWithString:@"http://www.maimaicha.com"];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:helplistView animated:YES];
        }else if (indexPath.row ==1){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            }else{
                UserSurggestViewController *userSurggestView = [[UserSurggestViewController alloc]init];
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
                self.navigationItem.backBarButtonItem = backItem;
                [self.navigationController pushViewController:userSurggestView animated:YES];
        }
    }else if (indexPath.section == 0){
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.maimaicha.com"]];
    }
}


-(void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)relogin:(NSNotification *)note
{
    NSLog(@"111");
    [self dismissViewControllerAnimated:NO completion:nil];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"INeedToLogin1" object:nil];
}

-(UIView *)backgroundView
{
    CGSize size = self.view.frame.size;
    if(_backgroundView == nil)
    {
        _backgroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [_backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return _backgroundView;
}

-(UITableView *)shoplistTableView
{
    CGPoint center = self.view.center;
    if(_shoplistTableView == nil)
    {
        _shoplistTableView = [[UITableView alloc]initWithFrame:CGRectMake(center.x, center.y, 0, 0)];
        _shoplistTableView.dataSource = self;
        _shoplistTableView.delegate = self;
        _shoplistTableView.tag =1;
    }
    return _shoplistTableView;
}
@end
