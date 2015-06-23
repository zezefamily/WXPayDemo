//
//  SignManager.m
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

//支付请求中用于加密的密钥 Key 审核通过后,在微信发送的邮件中查看
#define PaySignKey @"xxxxxxxxxxxxxxxxxxxxxxxx"

//财付通商户身份的标识,审核通过后,在财付通发送的邮件中查看
#define PartnerId @"xxxxxxxxxxxxxxxxxxxxxxxxx"

//财付通商户权限密钥 Key
#define paternerKey @"8934e7d15453e97507ef794cf7b0519d"

#define GET_AccessTokenURL @"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%@&secret=%@"
#define POST_GenprepayURL @"https://api.weixin.qq.com/pay/genprepay?access_token=%@"

#import "SignManager.h"
#import "PayRequestModel.h"

#import "AFHTTPRequestOperationManager.h"
#import <CommonCrypto/CommonDigest.h>

@interface SignManager ()
{
    OrderModel *_model;
    AFHTTPRequestOperationManager *manager;
    NSString *_sign;
}
@end

@implementation SignManager

- (void)signWithOrderModel:(OrderModel *)model
{
    _model = model;
//    请求access_Token
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:GET_AccessTokenURL,WX_AppID,WX_AppSecret] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *access_Token = dict[@"access_token"];
        [self signTogetPagkageWithToken:access_Token];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        错误返回 终止进程
        self.signBlock(nil,@"获取token时发生了错误");
        return;
    }];
}

- (void)signTogetPagkageWithToken:(NSString *)token
{
    NSMutableDictionary *postData = [self createPostData];
    [manager POST:[NSString stringWithFormat:POST_GenprepayURL,token] parameters:postData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        PayRequestModel *model = [[PayRequestModel alloc]init];
        if([[dict[@"errcode"]description]isEqualToString:@"0"]){
            
            model.prepayId = dict[@"prepayid"];
            model.package = postData[@"package"];
            model.nonceStr = postData[@"noncestr"];
            model.timeStamp = (UInt32)postData[@"timestamp"];
            model.partnerId = PartnerId;
            model.sign = _sign;
            
            self.signBlock(model,nil);
        }else{
            self.signBlock(nil,@"获取parpayid失败");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.signBlock(nil,@"获取parpayid失败");
    }];
}

- (NSMutableDictionary *)createPostData
{
    NSMutableDictionary *postData = [NSMutableDictionary dictionary];
    [postData setValue:WX_AppID forKey:@"appid"];
    [postData setValue:_model.userId forKey:@"traceid"];
    [postData setValue:[NSString stringWithFormat:@"%.0u",arc4random()] forKey:@"noncestr"];
    [postData setValue:[self changeNowTimeToTimeStampWithTime] forKey:@"timestamp"];
    [postData setValue:[self getPakage] forKey:@"package"];
    NSString *signTure = [self getApp_signatureWithDict:postData];
    [postData setValue:signTure forKey:@"app_signature"];
    [postData setValue:@"sha1" forKey:@"sign_method"];
    return postData;
}

- (NSString *)getApp_signatureWithDict:(NSMutableDictionary *)dict
{
    NSString *signature = [[NSString alloc]init];
    signature = [NSString stringWithFormat:@"%@&%@&%@&%@&%@&%@",dict[@"appid"],[NSString stringWithFormat:@"appkey=%@",PaySignKey],dict[@"noncestr"],dict[@"package"],dict[@"timestamp"],dict[@"traceid"]];
    _sign = [self sha1WithStr:signature];
    return [self sha1WithStr:signature];
}


- (NSString *)getPakage
{
    NSString *str = [[NSString alloc]init];
    NSMutableDictionary *packageDict = [NSMutableDictionary dictionary];
    
    [packageDict setValue:@"WX" forKey:@"bank_type"];
    [packageDict setValue:_model.body forKey:@"body"];
    [packageDict setValue:PartnerId forKey:@"partner"];
    [packageDict setValue:_model.tradeNumber forKey:@"out_trade_no"];
    [packageDict setValue:_model.totalFee forKey:@"total_fee"];
    [packageDict setValue:@"1" forKey:@"fee_type"];
    [packageDict setValue:@"http://testtest.zezefamily.com" forKey:@"notify_url"];
    [packageDict setValue:@"192.168.88.8" forKey:@"spbill_create_ip"];
    [packageDict setValue:@"UTF-8" forKey:@"input_charset"];
    
    NSArray *keys = [packageDict allKeys];
    NSArray *arr =  [self arrComparaeWithArr:keys];
    for(int i = 0;i<arr.count;i++){
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",arr[i],[packageDict objectForKey:arr[i]]]];
    }
    
    str = [str substringToIndex:str.length-1];
    NSString *urlecondeStr = str;
    str = [NSString stringWithFormat:@"%@key=%@",str,paternerKey];
    NSString *sign = [[self md5:str]uppercaseString];
    urlecondeStr = [urlecondeStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@&sign=%@",urlecondeStr,sign];
    
}



#pragma mark - MD5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - SHA1加密
- (NSString *)sha1WithStr:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

#pragma mark - 将 标准当前时间 ==> 时间戳
- (NSString *)changeNowTimeToTimeStampWithTime
{
    NSDate *dateNow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dateNow];
    NSDate *locateDate = [dateNow dateByAddingTimeInterval:interval];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[locateDate timeIntervalSince1970]];
    return timeSp;
}

#pragma mark - 元素排序
- (NSArray *)arrComparaeWithArr:(NSArray *)keys
{
    NSArray *arr =  [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        NSString* s1=[[NSString stringWithFormat:@"%@",obj1] uppercaseString];
        NSString* s2=[[NSString stringWithFormat:@"%@",obj2] uppercaseString];
        
        return [s1 compare:s2];
    }];
    return arr;
}

@end
