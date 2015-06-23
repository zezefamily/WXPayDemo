//
//  SignManager.h
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "OrderModel.h"
@class PayRequestModel;

typedef void (^PaySignResultBlock)(PayRequestModel *model,NSString *errStr);

@interface SignManager : NSObject

- (void)signWithOrderModel:(OrderModel *)model;
@property (nonatomic,strong) PaySignResultBlock signBlock;

@end
