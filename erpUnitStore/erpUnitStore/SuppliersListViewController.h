//
//  SuppliersListViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#import "SBJson.h"
#import "YMGlobal.h"
#import "MBProgressHUD.h"
@interface SuppliersListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSMutableArray *supplierListArray;
@end
