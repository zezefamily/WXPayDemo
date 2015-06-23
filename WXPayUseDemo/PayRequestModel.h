//
//  PayRequestModel.h
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayRequestModel : NSObject

@property (nonatomic,copy) NSString *partnerId;
@property (nonatomic,copy) NSString *prepayId;
@property (nonatomic,copy) NSString *package;
@property (nonatomic,copy) NSString *nonceStr;
@property (nonatomic,assign) UInt32 timeStamp;
@property (nonatomic,copy) NSString *sign;

@end
