//
//  GoodsSellListViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "YMUIButton.h"
@interface GoodsSellListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSMutableArray *goodsSellInformationArray;
@end
