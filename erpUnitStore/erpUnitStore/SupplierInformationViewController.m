//
//  SupplierInformationViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SupplierInformationViewController.h"

@interface SupplierInformationViewController ()

@end

@implementation SupplierInformationViewController
@synthesize providerNameLabel;
@synthesize providerAddressLabel;
@synthesize linkerLabel;
@synthesize phoneLabel;
@synthesize mobileLabel;
@synthesize faxLabel;
@synthesize emailLabel;
@synthesize remarkLabel;
@synthesize supplierDictionary = _supplierDictionary;
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
    self.navigationItem.title = @"供应商信息";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]]];
    [self.providerAddressLabel setNumberOfLines:0];
            NSLog(@"supplier%@",self.supplierDictionary);
    [self.providerNameLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Provider_name"]]];
        CGSize size = [[self.supplierDictionary objectForKey:@"Provider_address"] sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(200.0, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    [self.providerAddressLabel setFrame:CGRectMake(92, 91, 200, size.height)];
     [self.providerAddressLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Provider_address"]]];
     [self.linkerLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Linkman"]]];
     [self.phoneLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Phone"]]];
     [self.mobileLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Mobile"]]];
     [self.faxLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Fax"]]];
     [self.emailLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Email"]]];
     [self.remarkLabel setText:[NSString stringWithFormat:@"%@",[self.supplierDictionary objectForKey:@"Remark"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setProviderNameLabel:nil];
    [self setProviderAddressLabel:nil];
    [self setLinkerLabel:nil];
    [self setPhoneLabel:nil];
    [self setMobileLabel:nil];
    [self setFaxLabel:nil];
    [self setEmailLabel:nil];
    [self setRemarkLabel:nil];
    [super viewDidUnload];
}

- (NSMutableDictionary *)supplierDictionary
{
    if(_supplierDictionary == nil)
    {
        _supplierDictionary = [[NSMutableDictionary alloc]init];
    }
    return _supplierDictionary;
}
@end
