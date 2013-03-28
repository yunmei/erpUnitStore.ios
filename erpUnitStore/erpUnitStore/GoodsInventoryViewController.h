//
//  GoodsInventoryViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MKNetworkKit.h"
#import "YMGlobal.h"
#import "SBJson.h"
@interface GoodsInventoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSMutableArray *goodsInventoryArray;
@property (strong, nonatomic)UITableView *inventoryTableView;
@property (strong, nonatomic)NSString *monthString;
@end
