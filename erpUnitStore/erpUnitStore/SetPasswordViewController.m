//
//  SetPasswordViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()

@end

@implementation SetPasswordViewController
@synthesize userNameFeild;
@synthesize pwdFeild;
@synthesize tapGesture = _tapGesture;
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
- (IBAction)submitPress:(id)sender {
    if([self.userNameFeild.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不可为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if([self.pwdFeild.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户密码不可为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userNameFeild.text forKey:@"userName"];
        [defaults setObject:self.pwdFeild.text forKey:@"password"];
        [defaults synchronize];
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功,请重新登陆!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert2.delegate = self;
        alert2.tag = 1;
        [alert2 show];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INeedToLogin" object:nil];
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag ==1)
    {
        CGPoint center = self.view.center;
        [self.view setCenter:CGPointMake(center.x, center.y+65)];

    }
}

- (IBAction)disChange:(id)sender {
    [self.pwdFeild resignFirstResponder];
    [self.userNameFeild resignFirstResponder];
    [self.pwdFeild setText:@""];
    [self.userNameFeild setText:@""];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:self.tapGesture];
    if(textField.tag == 1)
    {
        CGPoint center = self.view.center;
        [self.view setCenter:CGPointMake(center.x, center.y-65)];
    }
}

- (void)viewDidUnload {
    [self setUserNameFeild:nil];
    [self setPwdFeild:nil];
    [super viewDidUnload];
}

- (UITapGestureRecognizer *)tapGesture
{
    if(_tapGesture == nil)
    {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeboard:)];
    }
    return _tapGesture;
}

-(void)hideKeboard:(id)sender
{
    [self.userNameFeild resignFirstResponder];
    [self.pwdFeild resignFirstResponder];
    [self.view removeGestureRecognizer:self.tapGesture];
}
@end
