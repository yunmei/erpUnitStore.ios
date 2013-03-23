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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    MKNetworkEngine *engine = [YMGlobal getEngine];
    MKNetworkOperation *op = [YMGlobal getOpFromEngine:engine];
    op = [YMGlobal setOperationParams:@"Get.AllUsers" apiparam:@"" execOp:op];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"111%@",[completedOperation responseString]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //NSLog(@"error%@",[completedOperation responseString]);
    }];
    [engine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
