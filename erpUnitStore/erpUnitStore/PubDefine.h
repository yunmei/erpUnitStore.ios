/*
 *  PubDefine.h
 *  iDMSS
 *
 *  Created by Flying on 11-6-25.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */


#if DEBUG
#define MCRelease(x) [x release];
#else
#define MCRelease(x) [x release]; 
#endif


#define MSG_DISMISS(title,msg,interval)  {if(baseAlert != NULL) return;\
baseAlert = [[UIAlertView alloc] initWithTitle:title \
message:msg  \
delegate:self \
cancelButtonTitle:nil  \
otherButtonTitles:nil]; \
[NSTimer scheduledTimerWithTimeInterval: interval target:self selector: @selector(performDismiss:) userInfo:nil repeats:NO];\
[baseAlert show]; }\

#define MSG(title,msg,ok)  {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title \
message:msg  \
delegate:nil \
cancelButtonTitle:ok  \
otherButtonTitles:nil]; \
[alert show];} 

