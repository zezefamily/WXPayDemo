//
//  OrderModel.h
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

/*
 
 >需要传入的参数
 *body=%E5%AE%89%E5%8D%93%E7%AD%BE%E5%90%8D%E6%B5%8B%E8%AF%95
 *total_fee=1
 *out_trade_no=1cdf14d1e3699d61d237cf76ce1c2dca
 
 >内部处理参数
 bank_type=WX
 fee_type=1
 input_charset=UTF-8
 notify_url=http%3A%2F% 2Fweixin.qq.com
 partner=1900000109
 spbill_create_ip=196.168.1.1
 sign=1F4D39942AEE58A0A5B47421ED4A3767"
 
*/


/*用于构造生成订单信息*/

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

/**商品描述*/
@property (nonatomic,copy) NSString *body;

/**订单号*/
@property (nonatomic,copy) NSString *tradeNumber;

/**订单总金额（单位为:分）*/
@property (nonatomic,copy) NSString *totalFee;

/**用户Id*/
@property (nonatomic,copy) NSString *userId;

@end





