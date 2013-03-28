//
//  GoodsInformationViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlotHeaders/CorePlot-CocoaTouch.h"
#import "MKNetworkKit.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "YMGlobal.h"
@interface GoodsInformationViewController : UIViewController<CPTPlotDataSource>

@property (strong, nonatomic)NSMutableArray *sellArray;
@property (strong, nonatomic)NSString  *goodsId;
//@property (strong, nonatomic)UILabel   *nameLabel;
//@property (strong, nonatomic)UILabel   *goodsIdLabel;
//@property (strong, nonatomic)UILabel   *stockAmountLabel;
//@property (strong, nonatomic)UILabel   *stockWarnLable;
//@property (strong, nonatomic)UILabel   *costPriceLable;
//@property (strong, nonatomic)UILabel   *standardPriceLabel;
//@property (strong, nonatomic)UILabel   *inNumLable;
//@property (st)
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockWarnLabel;
@property (strong, nonatomic) IBOutlet UILabel *costPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *inNunLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *standardPriceLabel;
@property (strong, nonatomic) NSString *monthString;
@property (strong, nonatomic) IBOutlet UILabel *lastYearLabel;

@end
