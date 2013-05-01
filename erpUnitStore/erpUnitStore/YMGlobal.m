//
//  YMGlobal.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-13.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "YMGlobal.h"
#import "Constants.h"
#import "ErpAppDelegate.h"

@implementation YMGlobal

+ (MKNetworkOperation *)getOperation:(NSMutableDictionary *)params
{
    return [ApplicationDelegate.appEngine operationWithPath:API_BASEURL params:params httpMethod:API_METHOD ssl:NO];
}

+ (void)loadImage:(NSString *)imageUrl andImageView:(UIImageView *)imageView
{
    [ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:imageUrl] onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        [imageView setImage:fetchedImage];
    }];
}
+ (void)loadImage:(NSString *)imageUrl andButton:(UIButton *)button andControlState:(UIControlState)buttonState
{
    [ApplicationDelegate.appEngine imageAtURL:[NSURL URLWithString:imageUrl] onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        [button setBackgroundImage:fetchedImage forState:buttonState];
    }];
}

+(MKNetworkEngine *)getEngine
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc]initWithHostName:API_HOSTNAME customHeaderFields:nil];
    return engine;
}

+(MKNetworkOperation *)getOpFromEngine:(MKNetworkEngine *)engine
{
    return [engine operationWithPath:API_BASEURL params:nil httpMethod:@"POST" ssl:NO];
}
+(MKNetworkOperation *)getOpFromEngineSn:(MKNetworkEngine *)engine
{
    return [engine operationWithPath:API_SNBASEURL params:nil httpMethod:@"POST" ssl:NO];
}

+(MKNetworkOperation *)setOperationParams:(NSString *)apiName apiparam:(NSString *)aipString execOp:(MKNetworkOperation *)op
{
    //发布时候去掉注释
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableString *baseString;
    if([defaults objectForKey:@"appkey"])
    {
        NSLog(@"1%@2%@3%@",[defaults objectForKey:@"appkey"],[defaults objectForKey:@"appkey"],[defaults objectForKey:@"secretkey"]);
       baseString = [NSMutableString stringWithFormat:@"{\"myparams\":{\"version\":\"2.0\",\"format\":\"json\",\"appkey\":\"%@\",\"secretkey\":\"%@\",\"apiname\":\"",[defaults objectForKey:@"appkey"],[defaults objectForKey:@"secretkey"]];
    }else{
        baseString = [[NSMutableString alloc]initWithString:@"{\"myparams\":{\"version\":\"2.0\",\"format\":\"json\",\"appkey\":\"9832C19A-1BB4-4E67-920A-04CD5E1B25B2\",\"secretkey\":\"d++ytcOds2TuuDhG7SWS7f40A5VcPYnH30B66ye8YTVY3gjNQTyJZArShDyVYmZqu8Y8yAQuHu4V1+K9YAnr9pz4VxawLayzJ7dyjCrV7Vm68nZ2U7IANO1wBJ50lAbuBHBz1LBhtRqkk706qmYuFFWEO9zcaLhRRX2xiTafDYs=\",\"apiname\":\""];
    }
//    {
//        NSMutableString *baseString = [[NSMutableString alloc]initWithString:@"{\"myparams\":{\"version\":\"2.0\",\"format\":\"json\",\"appkey\":\"%@\",\"secretkey\":\"%@\",\"apiname\":\"",[defaults objectForKey:@"appkey"],[defaults objectForKey:@"secretkey"]];
//       // NSString *baseString = [NSString stringWithFormat:@"{\"myparams\":{\"version\":\"2.0\",\"format\":\"json\",\"appkey\":\"%@\",\"secretkey\":\"%@\",\"apiname\":\"",[defaults objectForKey:@"appkey"],[defaults objectForKey:@"secretkey"]];
//    }
//    NSMutableString *baseString = [[NSMutableString alloc]initWithString:@"{\"myparams\":{\"version\":\"2.0\",\"format\":\"json\",\"appkey\":\"9832C19A-1BB4-4E67-920A-04CD5E1B25B2\",\"secretkey\":\"d++ytcOds2TuuDhG7SWS7f40A5VcPYnH30B66ye8YTVY3gjNQTyJZArShDyVYmZqu8Y8yAQuHu4V1+K9YAnr9pz4VxawLayzJ7dyjCrV7Vm68nZ2U7IANO1wBJ50lAbuBHBz1LBhtRqkk706qmYuFFWEO9zcaLhRRX2xiTafDYs=\",\"apiname\":\""];
    [baseString appendString:apiName];
    [baseString appendString:@"\",\"apiparam\":\"{"];
    [baseString appendString:aipString];
    [baseString appendString:@"}\"}}"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"application/json" forKey:@"Content-Type"];
    [dic setObject:@"application/json" forKey:@"Accept"];
    [dic setObject:[NSString stringWithFormat:@"%d", [baseString length]] forKey:@"Content-Length"];
    [op addHeaders:dic];
    NSInputStream *stream = [[NSInputStream alloc]initWithData:[baseString dataUsingEncoding:NSUTF8StringEncoding]];
    [op setUploadStream:stream];
    return op;
}

+(MKNetworkOperation *)setOperationSn:(NSString *)snString execOp:(MKNetworkOperation *)op
{
    NSMutableString *baseString = [[NSMutableString alloc]initWithString:@"{\"myparams\":{\"sn\":\""];
    [baseString appendString:snString];
    [baseString appendString:@"\"}}"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"application/json" forKey:@"Content-Type"];
    [dic setObject:@"application/json" forKey:@"Accept"];
    [dic setObject:[NSString stringWithFormat:@"%d", [baseString length]] forKey:@"Content-Length"];
    [op addHeaders:dic];
    NSInputStream *stream = [[NSInputStream alloc]initWithData:[baseString dataUsingEncoding:NSUTF8StringEncoding]];
    [op setUploadStream:stream];
    return op;
}
@end
