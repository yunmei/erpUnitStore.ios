//
//  SettingViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic)UIView *backgroundView;
@property (strong ,nonatomic)UITableView *shoplistTableView;
@property (strong, nonatomic)NSMutableArray *shoplistArray;
@end
