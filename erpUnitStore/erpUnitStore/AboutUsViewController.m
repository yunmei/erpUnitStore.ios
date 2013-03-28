//
//  AboutUsViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    self.navigationItem.title = @"关于我们";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIImageView *aboutImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [aboutImageView setImage:[UIImage imageNamed:@"aboutus.png"]];
    [self.view addSubview:aboutImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
