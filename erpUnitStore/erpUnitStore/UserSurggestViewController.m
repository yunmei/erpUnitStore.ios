//
//  UserSurggestViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-23.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "UserSurggestViewController.h"

@interface UserSurggestViewController ()

@end

@implementation UserSurggestViewController
@synthesize surggestContent;
@synthesize surggestLink;
@synthesize surggestTitle;
@synthesize tapGrestuer = _tapGrestuer;
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
    self.surggestContent.layer.borderWidth = 2.0;
    self.surggestContent.layer.cornerRadius = 8.0;
    self.surggestContent.layer.borderColor = [YMUIButton CreateCGColorRef:162.0 greenNumber:162.0 blueNumber:162.0 alphaNumber:162.0];
//    self.surggestContent.layer.shadowOffset = CGSizeMake(0, 5);
//    self.surggestContent.layer.shadowOpacity = 1.0;
//    self.surggestContent.layer.shadowColor = [UIColor blackColor].CGColor;
    self.surggestTitle.layer.borderWidth = 2.0;
    self.surggestTitle.layer.cornerRadius = 4.0;
    self.surggestTitle.layer.borderColor = [YMUIButton CreateCGColorRef:162.0 greenNumber:162.0 blueNumber:162.0 alphaNumber:162.0];
    self.surggestLink.layer.borderWidth = 2.0;
    self.surggestLink.layer.cornerRadius = 4.0;
    self.surggestLink.layer.borderColor = [YMUIButton CreateCGColorRef:162.0 greenNumber:162.0 blueNumber:162.0 alphaNumber:162.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    [self.view addGestureRecognizer:self.tapGrestuer];
    if(textView.tag == 2)
    {
        CGFloat x = self.view.center.x ;
        CGFloat y = self.view.center.y;
        [self.view setCenter:CGPointMake(x, y-50)];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 3)
    {
        CGFloat x = self.view.center.x ;
        CGFloat y = self.view.center.y;
        [self.view setCenter:CGPointMake(x, y-150)];
    }
    [self.view addGestureRecognizer:self.tapGrestuer];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGFloat x = self.view.center.x;
    CGFloat height = self.view.frame.size.height;
    [self.view setCenter:CGPointMake(x, height/2)];
    [self.view removeGestureRecognizer:self.tapGrestuer];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGFloat x = self.view.center.x;
    CGFloat height = self.view.frame.size.height;
    [self.view setCenter:CGPointMake(x, height/2)];
    [self.view removeGestureRecognizer:self.tapGrestuer];
}
- (void)viewDidUnload {
    [self setSurggestTitle:nil];
    [self setSurggestContent:nil];
    [self setSurggestLink:nil];
    [super viewDidUnload];
}

-(UITapGestureRecognizer *)tapGrestuer
{
    if(_tapGrestuer == nil)
    {
        _tapGrestuer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    }
    _tapGrestuer.numberOfTapsRequired =1;
    return _tapGrestuer;
}

-(void)keyBoardHide:(id)sender
{
    [self.surggestContent resignFirstResponder];
    [self.surggestLink resignFirstResponder];
    [self.surggestTitle resignFirstResponder];
}
- (IBAction)submitSurggest:(id)sender
{
    if([self.surggestContent.text isEqualToString:@""]||[self.surggestContent.text isEqualToString:@"请输入反馈内容"])
    {
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入反馈内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([self.surggestTitle.text isEqualToString:@""]){
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入反馈标题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"反馈提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert1.delegate = self;
        alert1.tag = 1;
        [alert1 show];
        self.surggestContent.text = @"";
        self.surggestLink.text = @"";
        self.surggestTitle.text = @"";
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
