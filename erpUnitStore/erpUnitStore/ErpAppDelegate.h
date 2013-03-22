//
//  ErpAppDelegate.h
//  erpUnitStore
//
//  Created by ken on 13-3-22.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkEngine.h"

#define ApplicationDelegate ((ErpAppDelegate *)[UIApplication sharedApplication].delegate)

@class ErpViewController;

@interface ErpAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ErpViewController *viewController;

@property (strong, nonatomic) MKNetworkEngine *appEngine;
@end
