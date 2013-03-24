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
@interface ErpViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextFeild;
@property (strong, nonatomic) NSMutableArray *userInformationArray;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestuer;
@end
