//
//  SlideViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface SlideViewController : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *pageScroll;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) UIButton *gotoMainViewButton;
@end
