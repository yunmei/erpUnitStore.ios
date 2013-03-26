//
//  SellChartViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-24.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlotHeaders/CorePlot-CocoaTouch.h"
@interface SellChartViewController : UIViewController<CPTPlotDataSource>

@property (strong, nonatomic)NSMutableArray *monthDataArray;

@end
