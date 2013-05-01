//
//  RegistSNViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "RegistSNViewController.h"
#import "SBJson.h"
@interface RegistSNViewController ()

@end

@implementation RegistSNViewController
@synthesize snTextField =_snTextField;
@synthesize tapGresture = _tapGresture;
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
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    UITextField *phoneFeild = [[UITextField alloc]initWithFrame:CGRectMake(85, 130, 180, 130)];
    [phoneFeild setBorderStyle:UITextBorderStyleRoundedRect];
    phoneFeild.enabled = NO;
    [self.view addSubview:phoneFeild];
    [self.view addSubview:self.snTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextView *)snTextField
{
    if(_snTextField == nil)
    {
        _snTextField = [[UITextView alloc]initWithFrame:CGRectMake(90 , 135, 170, 120)];
        //_snTextField.layer.borderWidth = 1.0;
        [_snTextField setFont:[UIFont systemFontOfSize:14.0]];
        _snTextField.delegate = self;
        _snTextField.returnKeyType = UIReturnKeyDone;
        [_snTextField setText:@"a3V4m9JLazJHl6HPigFcKdCoPNV9k17c06GON1RYS5Uy/++DG/S8G1FYbsRgn9T76SmwkZ6Ec0JfIDiCCzQ8cbEbvZa9N4qnvTZ6qjKWA8Il0LRd+EiyVHj228A7hHsw3ksByeEGiOXeRi12wRPu5M5XoiZS9li5Z5O1nZ2gdOQ="];
    }
    return _snTextField;
}

-(UITapGestureRecognizer *)tapGresture
{
    if(_tapGresture == nil)
    {
        _tapGresture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
    }
    return _tapGresture;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:self.tapGresture];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.view addGestureRecognizer:self.tapGresture];
}

- (IBAction)goRegist:(id)sender {
    if([self.snTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入SN" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        MKNetworkEngine *engine = [YMGlobal getEngine];
        MKNetworkOperation *op = [YMGlobal getOpFromEngineSn:engine];
        op = [YMGlobal setOperationSn:self.snTextField.text execOp:op];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJson_Parser *parser = [[SBJson_Parser alloc]init];
            NSMutableDictionary *data = [parser objectWithData:[completedOperation responseData]];
            NSLog(@"data%@",data);
            if([[data objectForKey:@"errcode"]isEqualToString:@"0"])
            {
                NSMutableDictionary *bodyData = [parser objectWithString:[data objectForKey:@"body"]];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[bodyData objectForKey:@"appkey"] forKey:@"appkey"];
                [defaults setObject:[bodyData objectForKey:@"secretkey"] forKey:@"secretkey"];
                [defaults setObject:[bodyData objectForKey:@"uri"] forKey:@"uri"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败,请重试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"error%@",[completedOperation responseString]);
        }];
        [engine enqueueOperation:op];
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneTextFeild resignFirstResponder];
    [self.snTextField becomeFirstResponder];
    return YES;
}

- (IBAction)goPass:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setPhoneTextFeild:nil];
    [super viewDidUnload];
}

-(void)hideKeyBoard:(id)sender
{
    [self.phoneTextFeild resignFirstResponder];
    [self.snTextField resignFirstResponder];
    [self.view removeGestureRecognizer:self.tapGresture];
}
- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
