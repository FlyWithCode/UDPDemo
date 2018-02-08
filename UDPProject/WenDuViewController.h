//
//  WenDuViewController.h
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "LedView.h"
@interface WenDuViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,ModelDelegate>
{
    BOOL _isLight;

}
@property(strong,nonatomic)UIButton* closeBtn;
@property(strong,nonatomic)UIWebView* webViewForSelectDate;
@property(strong,nonatomic)NSTimer* timer;
@property(strong,nonatomic)NSTimer* myTimer;
@property(nonatomic,strong)UIImageView *bigImageView;
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong)UISegmentedControl *segControl;
@property(nonatomic,assign)BOOL isDay;
@property(nonatomic,strong)NSData *nowDate;
@property(nonatomic,strong) Model *model;
@property(nonatomic,strong)LedView *ledView;
@property(nonatomic,assign)int udpReceiveMeg;
@property(nonatomic,assign)BOOL isSendSuccess;
@property(nonatomic,strong)  NSString *IP;
@property(nonatomic,assign) UInt16 port;
@property(nonatomic,strong)UILabel *lable;
@end
