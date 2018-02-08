//
//  CurtainViewController.h
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface CurtainViewController : UIViewController <ModelDelegate>
{
    CGFloat _height;
}
@property(nonatomic,strong)Model *model;
@property(nonatomic,strong) UIImageView *backImageV;
@property(nonatomic,strong) UIImageView *curtainImageV;
@property(nonatomic,strong)NSTimer *openTimer;
@property(nonatomic,strong)NSTimer *closeTimer;
@property(nonatomic,assign)NSString* udpReceiveMeg;
@property(nonatomic,assign)BOOL isSendSuccess;
@property(nonatomic,strong)  NSString *IP;
@property(nonatomic,assign) UInt16 port;
@end
