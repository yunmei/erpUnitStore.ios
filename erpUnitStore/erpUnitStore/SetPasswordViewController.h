//
//  SetPasswordViewController.h
//  erpUnitStore
//
//  Created by ken on 13-3-28.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPasswordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameFeild;

@property (strong, nonatomic) IBOutlet UITextField *pwdFeild;
@property (strong, nonatomic)UITapGestureRecognizer *tapGesture;
@end
