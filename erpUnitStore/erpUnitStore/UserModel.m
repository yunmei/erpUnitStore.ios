

#import "UserModel.h"

@implementation UserModel

@synthesize userid;
@synthesize username;
@synthesize password;


- (BOOL)login
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        if([db exec:@"CREATE TABLE IF NOT EXISTS user ('user_id', 'username', 'password');"])
        {
            NSString *query = [NSString stringWithFormat:@"INSERT INTO user ('user_id', 'username', 'password') VALUES ('%@','%@','%@');",self.userid,self.username,self.password];
            if([db exec:query])
            {
                [db close];
                return YES;
            }  
        }

    }
    return NO;
}

+ (void)logout
{
    [UserModel clearTable];
}

+ (UserModel *)getUserModel
{
    UserModel *userModel = [[UserModel alloc]init];
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        dictionary = [db fetchOne:@"select * from user"];
        userModel.userid = [dictionary objectForKey:@"user_id"];
        userModel.username = [dictionary objectForKey:@"username"];
        userModel.password = [dictionary objectForKey:@"password"];
        [db close];
    }
    return userModel;
}

+ (void)createTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"CREATE TABLE IF NOT EXISTS user ('user_id', 'username', 'password');"];
        [db close];
    }
}


+ (void)clearTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"delete from user;"];
        [db close];
    }
}

+(void)dropTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"drop table if exists user;"];
        [db close];
    }
}

@end
