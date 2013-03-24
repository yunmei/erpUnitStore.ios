

#import <Foundation/Foundation.h>
#import "YMDbClass.h"

@interface UserModel : NSObject

@property(strong,nonatomic)NSString *userid;
@property(strong,nonatomic)NSString *username;
@property(strong,nonatomic)NSString *password;

- (BOOL)login;
// 用户退出
+ (void)logout;
// 获取用户信息
+ (UserModel *)getUserModel;
// sqlite上创建用户表
+ (void)createTable;
// sqlite上清除用户表
+ (void)clearTable;
//注销表
+(void)dropTable;
@end
