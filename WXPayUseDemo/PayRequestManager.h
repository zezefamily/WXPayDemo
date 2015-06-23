//
//  PayRequestManager.h
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayRequestModel.h"
typedef void (^ResponseBlock)(NSString *errStr,int errCode);

@interface PayRequestManager : NSObject

- (void)payRequestWithModel:(PayRequestModel *)model;
@property (nonatomic,strong) ResponseBlock requestBlock;

@end
