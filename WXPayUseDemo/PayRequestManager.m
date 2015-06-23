//
//  PayRequestManager.m
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "PayRequestManager.h"
#import "WXApi.h"
@interface PayRequestManager ()<WXApiDelegate>

@end
@implementation PayRequestManager

- (void)payRequestWithModel:(PayRequestModel *)model
{
    PayReq *request = [[PayReq alloc]init];
    request.partnerId = model.partnerId;
    request.prepayId = model.prepayId;
    request.package = model.package;
    request.nonceStr = model.nonceStr;
    request.timeStamp = model.timeStamp;
    request.sign = model.sign;
    [WXApi safeSendReq:request];
    
}
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayReq class]]){
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
            {
                self.requestBlock(response.errStr,response.errCode);
                NSLog(@"订单支付成功,继续二次向服务器进行确认");
//                可以扩展在该类中直接向服务器发起确认请求
                //Config in here ...
                
                
            }
            break;
                
            default:
            {
                self.requestBlock(response.errStr,response.errCode);
                NSLog(@"交易发生错误");
//                可以扩展在该类中直接向服务器发起确认请求
                // Config in here ...
                
                
                
            }
            break;
        }
        
    }
}



@end
