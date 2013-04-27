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
#import "PullToRefreshTableView.h"
@interface GoodsInventoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong,nonatomic)NSMutableArray *goodsInventoryArray;
@property (strong, nonatomic)PullToRefreshTableView *inventoryTableView;
@property (strong, nonatomic)NSString *monthString;
//  全部  库存量 报警  分类按钮的定义
@property (strong, nonatomic)UIButton *catButton;
@property (strong, nonatomic)UIButton *allButton;
@property (strong, nonatomic)UIButton *inventoryButton;
@property (strong, nonatomic)UIButton *alarmButton;
@property (strong, nonatomic)UIView *catView;
@property (strong, nonatomic)UIView *backgroundView;
@property (strong, nonatomic)UITableView *firstCatTableView;
@property (strong, nonatomic)UITableView *secondCatTableView;
@property (strong, nonatomic)NSMutableArray *firstCatArray;
@property (strong, nonatomic)NSMutableArray *secondCatArray;
@property (strong, nonatomic)NSString *selectedCatId;
@end
