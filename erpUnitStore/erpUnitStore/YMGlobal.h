//
//  YMGlobal.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-13.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
@interface YMGlobal : NSObject



//获取MKNetworkEngine
+(MKNetworkEngine *)getEngine;

// 获取MKNetworkOperation
+(MKNetworkOperation *)getOpFromEngine:(MKNetworkEngine *)engine;
+ (MKNetworkOperation *)getOperation:(NSMutableDictionary *)params;
//为MKNetworkOperation设置参数
+(MKNetworkOperation *)setOperationParams:(NSString *)apiName
                                 apiparam:(NSString *)aipString
                                   execOp:(MKNetworkOperation *)op;
+(MKNetworkOperation *)getOpFromEngineSn:(MKNetworkEngine *)engine;
+(MKNetworkOperation *)setOperationSn:(NSString *)snString execOp:(MKNetworkOperation *)op;
// 加载图片
+ (void)loadImage:(NSString *)imageUrl andImageView:(UIImageView *)imageView;
+ (void)loadImage:(NSString *)imageUrl andButton:(UIButton *)button andControlState:(UIControlState)buttonState;
@end
