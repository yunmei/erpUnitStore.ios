//
//  MonitorViewController.h
//  erpUnitStore
//
//  Created by ken on 13-4-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoWnd.h"
#import "PopupBox.h"

@interface MonitorViewController : UIViewController<IAV_LoginCallback,IAV_RealPlayCallback,popUpBoxDelegate>
{
    AV_HANDLE	m_hLogin;
	AV_HANDLE	m_hRealplay;
    
    int     m_nPTZ;
}
@property (strong, nonatomic) IBOutlet UITextField *serverTextField;
@property (strong, nonatomic) IBOutlet UITextField *portTextField;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *pswTextFeild;
@property (strong, nonatomic) IBOutlet UITextField *channelTextFeild;
@property (strong, nonatomic) IBOutlet VideoWnd *playView;


- (IBAction)login:(id)sender;

- (IBAction)logout:(id)sender;

- (IBAction)start:(id)sender;

- (IBAction)stop:(id)sender;

- (IBAction)backgroundTap:(id)sender;


- (IBAction)PTZControl:(id)sender;
- (IBAction)PTZControlDown:(id)sender;


- (void) PTZControlOper:(BOOL)bStop;

- (IBAction)backView:(id)sender;

@end
