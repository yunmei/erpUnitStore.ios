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
@interface ErpViewController ()

@end

@implementation ErpViewController
@synthesize userNameTextFeild;
@synthesize pwdTextFeild;
@synthesize userInformationArray = _userInformationArray;
@synthesize tapGestuer  = _tapGestuer;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]]];
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    op = [YMGlobal setOperationParams:@"Get.AllUsers" apiparam:@"" execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
        NSLog(@"data%@",data);
        if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
        {
           self.userInformationArray = [parser objectWithString:[data objectForKey:@"body"]];
            NSLog(@"self.userInformationArray%@",self.userInformationArray);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}

//点击登陆的时候
- (IBAction)onLoginButtonPressed:(id)sender {
    //正式发布的时候将判断去掉
//    if([self.userNameTextFeild.text isEqualToString:@""]||[self.pwdTextFeild.text isEqualToString:@""])
//    {
//        UIAlertView *loginInfomationAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请将用户名密码输入完整!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [loginInfomationAlert show];
//    }else{
//        if([self.userInformationArray count]>0)
//        {
//            int i = 0;
//            for(id o in self.userInformationArray)
//            {
//                NSMutableDictionary *unitUserInformationDictionary = o;
//                if([[unitUserInformationDictionary objectForKey:@"User_Name"] isEqualToString:self.userNameTextFeild.text])
//                {
//                    i++;
//                    if([[unitUserInformationDictionary objectForKey:@"Password"] isEqualToString:self.pwdTextFeild.text])
//                    {
//                        UserModel *user = [[UserModel alloc]init];
//                        user.userid = [unitUserInformationDictionary objectForKey:@"User_ID"];
//                        user.username = [unitUserInformationDictionary objectForKey:@"User_Name"];
//                        user.password = [unitUserInformationDictionary objectForKey:@"Password"];
//                        if([user login])
//                        {
//                            MenuViewController *menuVC = [[MenuViewController alloc]init];
//                            [self presentViewController:menuVC animated:NO completion:nil];
//                        }
//                    }else{
//                        UIAlertView *loginInfomationAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误，请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                        [loginInfomationAlert show];
//                    }
//                }
//            }
//            if(i == 0)
//            {
//                UIAlertView *loginInfomationAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该用户名不存在!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [loginInfomationAlert show];
//            }
//        }
//    }
    MenuViewController *menuVC = [[MenuViewController alloc]init];
    [self presentViewController:menuVC animated:NO completion:nil];
    
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
