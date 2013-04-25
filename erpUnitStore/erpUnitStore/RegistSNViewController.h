//
//  RegistSNViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "YMGlobal.h"
#import "SBJson.h"
@interface RegistSNViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (strong,nonatomic)UITextView *snTextField;
@property (strong, nonatomic) UITapGestureRecognizer *tapGresture;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextFeild;

@end
