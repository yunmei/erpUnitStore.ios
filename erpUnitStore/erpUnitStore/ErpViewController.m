//
//  ErpViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-22.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "ErpViewController.h"
#import "SBJson.h"
#import "Constants.h"
#import "RegistSNViewController.h"
@interface ErpViewController ()

@end

@implementation ErpViewController
@synthesize userNameTextFeild;
@synthesize pwdTextFeild;
@synthesize userInformationArray = _userInformationArray;
@synthesize tapGestuer  = _tapGestuer;
@synthesize registerView = _registerView;
@synthesize phoneTextFeild = _phoneTextFeild;
@synthesize snTextView = _snTextView;
@synthesize registerButton = _registerButton;
@synthesize passButton = _passButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"hasLogin"])
    {
        [self.userNameTextFeild setText:@"admin"];
        [self.pwdTextFeild setText:@"admin"];
    }
    if([defaults objectForKey:@"appkey"])
    {
        NSLog(@"已经注册用户");
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"您的应用还未注册,是否前去注册?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"去注册 " otherButtonTitles:@"跳过", nil];
        [actionSheet showInView:self.view];
    }

//    MKNetworkEngine *engine = [YMGlobal getEngine];
//    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
//    op = [YMGlobal setOperationParams:@"Get.AllUsers" apiparam:@"" execOp:op];
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        SBJsonParser *parser = [[SBJsonParser alloc]init];
//        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
//        NSLog(@"data%@",data);
//        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
//        {
//           self.userInformationArray = [parser objectWithString:[data objectForKey:@"body"]];
//            NSLog(@"self.userInformationArray%@",self.userInformationArray);
//        }
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"error%@",[completedOperation responseString]);
//    }];
//    [engine enqueueOperation:op];
}

-(void)viewWillAppear:(BOOL)animated
{
//    CGSize size = [UIScreen mainScreen].bounds.size;
//    UIImageView * screenImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,size.height)];
//    [screenImage setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.5]];
//    [self.view addSubview:screenImage];
//    [self.registerView addSubview:self.phoneTextFeild];
//    [self.registerView addSubview:self.snTextView];
//    [self.registerView addSubview:self.registerButton];
//    [self.registerView addSubview:self.passButton];    
//    [self.view addSubview:self.registerView];

    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //原内容
    if(buttonIndex == 0)
    {
         RegistSNViewController *snVC = [[RegistSNViewController alloc]init];
        UINavigationController *SNNavigation = [[UINavigationController alloc]initWithRootViewController:snVC];
        [self presentViewController:SNNavigation animated:YES completion:nil];
    }else if (buttonIndex == 1){
        NSLog(@"1");
    }
}

//点击登陆的时候
- (IBAction)onLoginButtonPressed:(id)sender {
    //正式发布的时候将判断去掉
    if([self.userNameTextFeild.text isEqualToString:@""]||[self.pwdTextFeild.text isEqualToString:@""])
    {
        UIAlertView *loginInfomationAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请将用户名密码输入完整!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [loginInfomationAlert show];
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"hasLogin"])
        {
            NSLog(@"haslogin");
            NSLog(@"userName%@",[defaults objectForKey:@"userName"]);
            NSLog(@"password%@",[defaults objectForKey:@"password"]);
            if(![[defaults objectForKey:@"userName"]isEqualToString:self.userNameTextFeild.text])
            {
                UIAlertView *loginInfomationAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不正确!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [loginInfomationAlert show];
            }else if(![[defaults objectForKey:@"password"]isEqualToString:self.pwdTextFeild.text]){
                UIAlertView *loginInfomationAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不正确!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [loginInfomationAlert show];
            }else{
                self.pwdTextFeild.text = @"";
                MenuViewController *menuVC = [[MenuViewController alloc]init];
                [self presentViewController:menuVC animated:NO completion:nil];
            }
        }else{
            [defaults setObject:self.userNameTextFeild.text forKey:@"userName"];
            [defaults setObject:self.pwdTextFeild.text forKey:@"password"];
            self.pwdTextFeild.text = @"";
            [defaults setObject:@"YES" forKey:@"hasLogin"];
            [defaults synchronize];
            MenuViewController *menuVC = [[MenuViewController alloc]init];
            [self presentViewController:menuVC animated:NO completion:nil];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag == 0)
    {
        [textField resignFirstResponder];
        [self.pwdTextFeild becomeFirstResponder];
    }else if (textField.tag == 1){
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:self.tapGestuer];
    if(textField.tag ==1)
    {
        CGPoint viewCenter = self.view.center;
        [self.view setCenter:CGPointMake(viewCenter.x, viewCenter.y-40)];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:self.tapGestuer];
    if(textField.tag == 1)
    {
        [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y+40)]; 
    }
}

- (NSMutableArray *)userInformationArray
{
    if(_userInformationArray == nil)
    {
        _userInformationArray = [[NSMutableArray alloc]init];
    }
    return _userInformationArray;
}

- (UITapGestureRecognizer *)tapGestuer
{
    if(_tapGestuer == nil)
    {
        _tapGestuer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
    }
    return _tapGestuer;
}

- (void)hideKeyBoard:(id)sender
{
    [self.userNameTextFeild resignFirstResponder];
    [self.pwdTextFeild resignFirstResponder];
}


@end
