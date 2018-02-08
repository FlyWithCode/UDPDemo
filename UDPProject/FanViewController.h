//
//  FanViewController.h
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "FanView.h"
@interface FanViewController : UIViewController <ModelDelegate>
@property(nonatomic,strong)Model *model;
@property(nonatomic,strong) FanView *fanView;
@property(nonatomic,strong) UIImageView *backImageV;
@property(nonatomic,assign)NSString* udpReceiveMeg;
@property(nonatomic,assign)BOOL isSendSuccess;
@property(nonatomic,strong)  NSString *IP;
@property(nonatomic,assign) UInt16 port;
@end
