//
//  HelpViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *helpListWebView;
@property(strong,nonatomic)NSURL *requestString;
@end
