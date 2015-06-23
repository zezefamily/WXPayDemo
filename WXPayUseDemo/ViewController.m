//
//  ViewController.m
//  WXPayUseDemo
//
//  Created by zezefamily on 15/6/19.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "ViewController.h"
#import "PayRequestManager.h"
#import "SignManager.h"
#import "OrderModel.h"
@interface ViewController ()
@property (nonatomic,strong) PayRequestManager *payManager;
@property (nonatomic,strong) SignManager *signManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    构造订单信息
    OrderModel *model = [[OrderModel alloc]init];
    model.body = @"测试商品";
    model.tradeNumber = @"201506190000";
    model.totalFee = @"12";
    model.userId = @"e4kslf6rrile233232dksfg";
    
    
//    初始化签名请求和支付请求
    self.signManager = [[SignManager alloc]init];
    [self.signManager signWithOrderModel:model];
    self.signManager.signBlock = ^(PayRequestModel *model,NSString *errStr){
        //  签名信息反馈
        if(errStr == nil){
            // 初始化支付请求
            self.payManager = [[PayRequestManager alloc]init];
            [self.payManager payRequestWithModel:model];
            self.payManager.requestBlock = ^(NSString *errStr,int errCode){
                // 支付结果反馈
                if(errCode == 0){
                    //付款成功
                }
            };
        }else {
            
            NSLog(@"errStr == %@",errStr);
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
