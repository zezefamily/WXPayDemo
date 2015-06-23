//
//  ZZRequestManager.m
//  WaterBBS
//
//  Created by zezefamily on 15/6/6.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "ZZRequestManager.h"
#import "ZZReachbility.h"

@interface ZZRequestManager ()
{
    ZZReachbility *_zzReachbility;
}
@end
@implementation ZZRequestManager
//- (id)init
//{
//    self = [super init];
//    if(self ){
//        _zzReachbility = [[ZZReachbility alloc]init];
//        [_zzReachbility startToReachbility];
//    }
//    return self;
//}

+ (void)ZZPostWithURL:(NSString *)URL params:(NSDictionary *)params success:(void(^)(NSDictionary *dict))getDict failure:(void(^)(NSError *error))getError
{
    //[self CheckNetStatus];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        getDict(dict);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        getError(error);
        
    }];

}



//- (void)CheckNetStatus
//{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:NotificationName object:nil];
//    
//}
//- (void)netChange:(NSNotification *)notification
//{
//    NSDictionary *dict = notification.object;
//    NSNumber *status = dict[@"status"];
//    if([status integerValue] == 0){
//        return;
//    }
//    
//}

- (void)httpRequest
{

    
}

@end
