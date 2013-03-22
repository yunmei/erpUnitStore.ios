//
//  ErpViewController.m
//  erpUnitStore
//
//  Created by ken on 13-3-22.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "ErpViewController.h"
#import "SBJson.h"
@interface ErpViewController ()

@end

@implementation ErpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSString *myparams = [NSString stringWithFormat:@"{\"version\":\"2.0\",\"format\":\"json\",\"appkey\":\"9832C19A-1BB4-4E67-920A-04CD5E1B25B2\",\"secretkey\":\"vi3lwuR2Dy7pOFkCKE0khZsxGn4tBJpl7ZTXeoPfhfPWXoOdueuPNMoBL6jmyFXWZ6LGhTF/ys2pfSPwazUcTisCYbkb5/NoVh5dM2BidlQlkJ6T2ZBdh82Q3nFD0yeKPfmhSAFgtzKOFK4RfTOa04EA2GuR4WUNVCw8mygWliA=\",\"apiname\":\"Get.Sysuser\",\"apiparam\":{\"Shop_id\":\"1\"}}"];
    NSString *myparams = @"";
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSMutableDictionary *object = [parser objectWithString:myparams];
    NSLog(@"object%@",object);
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:myparams forKey:@"myparams"];
    MKNetworkOperation *op = [YMGlobal getOperation:param];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"111%@",[completedOperation responseString]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
       NSLog(@"111%@",[completedOperation responseString]);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
