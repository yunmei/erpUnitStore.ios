//
//  SellChartViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-24.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlotHeaders/CorePlot-CocoaTouch.h"
#import "YMGlobal.h"
#import "MKNetworkKit.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#define DAYDATA      @"day"
#define WEEKDATA     @"week"
#define MONTHDATA    @"month"
#define QUARTERDATA  @"quarter"
#define YEARDATA     @"year"
@interface SellChartViewController : UIViewController<CPTPlotDataSource>

@property (strong, nonatomic)NSMutableArray *monthDataArray;
@property (strong, nonatomic)NSMutableArray *dayDataArray;
@property (strong, nonatomic)NSMutableArray *quarterDataArray;
@property (strong, nonatomic)NSMutableArray *yearDataArray;
@property (strong, nonatomic)NSMutableArray *weekDataArray;

@end
