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
@interface SettingViewController ()

@end

@implementation SettingViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section ==0)
    {
        return 1;
    }else if (section ==1){
        return 2;
    }else if (section ==2){
        return 3;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
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
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        }else{
            cell.textLabel.text = @"修改密码";
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
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        if(indexPath.row ==0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已清除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            SetPasswordViewController *setPassVC = [[SetPasswordViewController alloc]init];
            [self.navigationController pushViewController:setPassVC animated:YES];
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
@end
