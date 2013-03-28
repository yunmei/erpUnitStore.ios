//
//  LibraryInformationController.m
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "LibraryInformationController.h"

@interface LibraryInformationController ()

@end

@implementation LibraryInformationController
@synthesize goodsNameLabel;
@synthesize typeNameLabel;
@synthesize goodsIdLabel;
@synthesize createDateLabel;
@synthesize validTimeLabel;
@synthesize costMoneyLabel;
@synthesize amountLabel;
@synthesize endDateLabel;
@synthesize inNoteIdLabel;
@synthesize OperatorDateLabel;
@synthesize userNameLabel;
@synthesize OperatorIdLabel;
@synthesize libraryInfoDictionary = _libraryInfoDictionary;
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
    self.navigationItem.title = @"入库详情";
    NSLog(@"self.libraryInfoDictionary%@",self.libraryInfoDictionary);
    // Do any additional setup after loading the view from its nib.
    [self.goodsNameLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Goods_Name"]]];
    [self.typeNameLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Type_Name"]]];
    [self.goodsIdLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Goods_ID"]]];
    [self.createDateLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Create_Date"]]];
    [self.validTimeLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Valid_Time"]]];
    [self.costMoneyLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Cost_Money"]]];
    [self.amountLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Amount"]]];
    [self.endDateLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"End_Date"]]];
    [self.inNoteIdLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"InNote_ID"]]];
    [self.OperatorDateLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Operator_Date"]]];
    [self.OperatorIdLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"Operator_ID"]]];
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@",[self.libraryInfoDictionary objectForKey:@"User_Name"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setGoodsNameLabel:nil];
    [self setTypeNameLabel:nil];
    [self setGoodsIdLabel:nil];
    [self setCreateDateLabel:nil];
    [self setValidTimeLabel:nil];
    [self setCostMoneyLabel:nil];
    [self setAmountLabel:nil];
    [self setEndDateLabel:nil];
    [self setInNoteIdLabel:nil];
    [self setOperatorDateLabel:nil];
    [self setOperatorIdLabel:nil];
    [self setUserNameLabel:nil];
    [super viewDidUnload];
}

- (NSMutableDictionary *)libraryInfoDictionary
{
    if(_libraryInfoDictionary == nil)
    {
        _libraryInfoDictionary = [[NSMutableDictionary alloc]init];
    }
    return _libraryInfoDictionary;
}
@end
