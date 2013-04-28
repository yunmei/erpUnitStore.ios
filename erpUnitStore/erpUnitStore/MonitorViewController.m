//
//  MonitorViewController.m
//  erpUnitStore
//
//  Created by ken on 13-4-27.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "MonitorViewController.h"
#import "ErpViewController.h"
@interface MonitorViewController ()

@end

@implementation MonitorViewController
@synthesize serverTextField,portTextField,userTextField,pswTextFeild,channelTextFeild,playView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    m_hLogin = NULL;
    m_hRealplay = NULL;
    
    CGRect rect = self.playView.frame;
    UIImageView *back = [[UIImageView alloc]initWithFrame:rect];
    back.image = [UIImage imageNamed:@"loading.png"];
    [self.view addSubview:back];
    [self.view bringSubviewToFront:self.playView];
    
    PopupBox *myPopUpBox = [[PopupBox alloc]initWithFrame:CGRectMake(15, 452,160,30) delegate:self Title:@""];
    NSArray *boxData = [[NSArray alloc] initWithObjects:@"UP", @"DOWN", @"LEFT", @"RIGHT", @"ZOOM IN", @"ZOOM OUT", @"FOCUS ADD", @"FOCUS DEC", @"APERTURE ADD", @"APERTURE DEC", nil];
    for (int i= 0; i < 10 ;  i++)
    {
        myPopUpBox->data[i] = i;
    }
    
    myPopUpBox.popUpBoxDatasource = boxData;
    NSString *initData = [boxData objectAtIndex:0];
    m_nPTZ = 0;
    myPopUpBox.selectContentLabel.text = initData;
    [self.view addSubview:myPopUpBox];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if (m_hLogin > 0)
	{
		[AVNetSDK AV_Logout:m_hLogin];
	}
	
    AV_IN_Login InParam = {0};
    InParam.nStructSize = sizeof(AV_IN_Login);
    InParam.szDevIp = (char *)[self.serverTextField.text UTF8String];
    InParam.nDevPort = [self.portTextField.text intValue];
    InParam.szDevUser = (char *)[self.userTextField.text UTF8String];
    InParam.szDevPwd = (char *)[self.pswTextFeild.text UTF8String];
    InParam.bReconnect = FALSE;
    InParam.pConnStatusCallback = self;
    InParam.pUserParam = NULL;
    
    AV_OUT_Login outParam = {0};
    outParam.nStructSize = sizeof(AV_OUT_Login);
	
	AV_HANDLE lLoginID = [AVNetSDK AV_Login:&InParam Out:&outParam];
    
	if (lLoginID > 0)
	{
		MSG(@"登录",@"成功",@"确定")
		
		m_hLogin = lLoginID;
	}
	else
	{
		switch (outParam.emErrorCode)
        {
            case AV_Login_Error_Timeout:
                MSG(@"失败",@"没有响应！",@"确定")
                break;
                
            case AV_Login_Error_Password:
                MSG(@"失败",@"密码不正确！",@"确定")
                break;
                
            case AV_Login_Error_UserName:
                MSG(@"失败",@"帐号不存在！",@"确定")
                break;
                
            case AV_Login_Error_ReLogin:
                MSG(@"失败",@"帐号已登录！",@"确定")
                break;
                
            case AV_Login_Error_Locked:
                MSG(@"失败",@"帐号被锁定！",@"确定")
                break;
                
            case AV_Login_Error_Blacklist:
                MSG(@"失败",@"帐号被列入黑名单！",@"确定")
                break;
                
                
            case AV_Login_Error_DeviceBusy:
                MSG(@"失败",@"资源不足，系统忙！",@"确定")
                break;
                
                
            default:
                MSG(@"登录",@"失败",@"确定")
                break;
        }
	}
    
}

- (IBAction)logout:(id)sender {
    if (m_hLogin > 0)
	{
		[AVNetSDK AV_Logout:m_hLogin];
		
		m_hLogin = NULL;
		m_hRealplay = NULL;
		
	}
}

- (IBAction)start:(id)sender {
    
	if (m_hLogin > 0)
	{
        float fDisplayScale = 1.0;
        if ([UIScreen instancesRespondToSelector:@selector(scale)])
        {
            fDisplayScale = (CGFloat)[[UIScreen mainScreen] scale];
        }
        
		//监视
        AV_IN_RealPlay inParamRealPlay = {0};
        inParamRealPlay.nStructSize = sizeof(AV_IN_RealPlay);
        inParamRealPlay.nChannelID = [self.channelTextFeild.text intValue];
        inParamRealPlay.nSubType = 1;
        inParamRealPlay.pUIView =   self.playView;
        inParamRealPlay.fDisplayScale = fDisplayScale;
        inParamRealPlay.nDelayTime = 1000;
        inParamRealPlay.pRealCallback = self;
        inParamRealPlay.pUserParam = NULL;
        
        AV_OUT_RealPlay outParamRealPlay = {0};
        outParamRealPlay.nStructSize = sizeof(AV_OUT_RealPlay);
        
		AV_HANDLE lRealPlayID =	[AVNetSDK AV_RealPlay:m_hLogin In:&inParamRealPlay Out:&outParamRealPlay];
		
		if (lRealPlayID > 0)
		{
			MSG(@"监视",@"成功",@"确定")
			
			m_hRealplay = lRealPlayID;
			
			[AVNetSDK AV_OpenAudio:lRealPlayID Interface:0];
		}
		else
		{
			MSG(@"监视",@"失败",@"确定")
		}
		
	}

}



- (IBAction)PTZControl:(id)sender {
    [self PTZControlOper:YES];
}

- (IBAction)PTZControlDown:(id)sender {
    [self PTZControlOper:NO];
}

- (IBAction)stop:(id)sender {
    if (m_hRealplay > 0)
	{
		[AVNetSDK AV_StopRealPlay:m_hRealplay];
        
		m_hRealplay = NULL;
	}
}

- (IBAction)backgroundTap:(id)sender {
    [self.portTextField resignFirstResponder];
    [self.serverTextField resignFirstResponder];
    [self.userTextField resignFirstResponder];
    [self.pswTextFeild resignFirstResponder];
    [self.channelTextFeild resignFirstResponder];
}

- (void) PTZControlOper:(BOOL)bStop
{
    if (m_hLogin > 0)
    {
        int nChannel = [self.channelTextFeild.text intValue];
        
        int ptzStep  = 3;  // 1~8
        
        
        AV_IN_PTZ inPTZParam = {0};
        inPTZParam.nStructSize = sizeof(AV_IN_PTZ);
        inPTZParam.nChannelID = nChannel;
        inPTZParam.bOpen = YES;
        
        AV_OUT_PTZ outPTZParam = {0};
        outPTZParam.nStructSize = sizeof(AV_OUT_PTZ);
        
        switch (m_nPTZ)
        {
            case 0:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = ptzStep;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Up;
                break;
            case 1:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = ptzStep;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Down;
                
                break;
            case 2:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = ptzStep;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Left;
                
                break;
            case 3:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = ptzStep;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Right;
                
                break;
            case 4:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = 1;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Zoom_Add;
                
                break;
            case 5:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = 1;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Zoom_Dec;
                
                break;
            case 6:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = 1;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Focus_Add;
                
                break;
            case 7:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = 1;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Focus_Dec;
                
                break;
            case 8:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = 1;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Aperture_Add;
                
                break;
            case 9:
                inPTZParam.nParam1 = 0;
                inPTZParam.nParam2 = 1;
                inPTZParam.nParam3 = 0;
                inPTZParam.emType = AV_PTZ_Aperture_Dec;
                
                break;
            default:
                return;
        }
        
        [AVNetSDK AV_ControlPTZ:m_hLogin In:&inPTZParam Out:&outPTZParam];
    }
}

- (IBAction)backView:(id)sender {
    if (m_hRealplay > 0)
	{
		[AVNetSDK AV_StopRealPlay:m_hRealplay];
        
		m_hRealplay = NULL;
	}
    [self dismissViewControllerAnimated:YES completion:nil];
}


-  (void) popUpBox:(PopupBox *)popUpBox IndexChanged:(NSInteger)index
{
    m_nPTZ = index;
}

- (void) popUpBox:(PopupBox *)popUpBox willEditing:(NSInteger)index
{
    
}

- (AV_int32) onLoginConnectStatus: (AV_HANDLE)hLoginID Status: (AV_BOOL)bOnline IP: (char *)szDevIp Port: (AV_int32)nDevPort Param: (void*)pUserParam
{
    if (bOnline == FALSE)
    {
        [self performSelectorOnMainThread:@selector(handleLoginDisconnect) withObject:nil waitUntilDone:NO];
    }
    
    return 0;
}

// 未经码流分析pMediaInfo＝NULL
- (AV_int32) onRealData: (AV_HANDLE)hRealHandle Data: (AV_BYTE *)pBuf Len: (AV_int32)nBufLen MediaInfo: (AV_MediaInfo *)pMediaInfo Param: (void*)pUserParam
{
    return 0;
}

- (AV_int32) onRealConnectStatus: (AV_HANDLE)hRealHandle Status: (AV_BOOL)bOnline LoginID: (AV_HANDLE)hLoginID Param: (void*)pUserParam
{
    if (bOnline == FALSE)
    {
        [self performSelectorOnMainThread:@selector(handleRealDisconnect) withObject:nil waitUntilDone:NO];
    }
    
    return 0;
}


- (AV_int32) onRealSolutionChanged: (AV_HANDLE)hRealHandle Width: (AV_int32)nWidth Height: (AV_int32)nHeight Param: (void*)pUserParam
{
    return 0;
}

- (AV_int32) onRealUnsupportStream: (AV_HANDLE)hRealHandle  Param: (void*)pUserParam
{
    return 0;
}

- (AV_int32) onRealLostFrame: (void*)pUserParam
{
    return 0;
}


-(void) handleLoginDisconnect
{
	MSG(@"登录",@"断线",@"确定")
	
	if (m_hLogin > 0)
	{
		if (m_hRealplay>0)
		{
			[AVNetSDK AV_StopRealPlay:m_hRealplay];
            m_hRealplay = NULL;
		}
		
		[AVNetSDK AV_Logout:m_hLogin];
		m_hLogin = NULL;
	}
}

- (void) handleRealDisconnect
{
	if (m_hRealplay>0)
	{
		[AVNetSDK AV_StopRealPlay:m_hRealplay];
        m_hRealplay = NULL;
	}
	
}

@end
