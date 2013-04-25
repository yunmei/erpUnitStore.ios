//
//  ErpViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-22.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "ErpAppDelegate.h"
#import "UserModel.h"
#import "MenuViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ErpViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextFeild;
@property (strong, nonatomic) NSMutableArray *userInformationArray;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestuer;
@property (strong, nonatomic) UIView *registerView;
@property (strong, nonatomic) UITextField *phoneTextFeild;
@property (strong, nonatomic) UITextView  *snTextView;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIButton *passButton;
@end
