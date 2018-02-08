//
//  WenDuViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "WenDuViewController.h"
#import "SunView.h"
#import "StartView.h"
#import "CloudView.h"

#define TurnON_LED  @"1"  //49
#define TurnOFF_LED  @"2" //50

@interface WenDuViewController ()

@end

@implementation WenDuViewController
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
    //开启时器self.myTimer
    [self.myTimer setFireDate:[NSDate distantPast]];
    

	
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(  breakVC)];
    
    [self makeBigView];
    [self changeDay];
    [self makeLedView];
    self.ledView.hidden=YES;
    [self openLedButton];
    self.IP=[[NSUserDefaults standardUserDefaults]objectForKey:@"IP"];
   self.port=[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"port"]] intValue];
    
    NSLog(@"ip:%@ port:%d", self.IP,self.port);
    self.model=[[Model alloc]init];
    self.model.delegate=self;
    [self.model openUDPServer];
    //[self.model sendMassage:@"31" IP:self.IP Port:self.port];
    self.myTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeDay) userInfo:nil repeats:YES];
    


    
}

-(void)breakVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.model.udpSocket close];
     //关闭定时器self.myTimer
    [self.myTimer setFireDate:[NSDate distantFuture]];

    NSLog(@"视图已经消失－－－－");
    

}
#pragma mark--
#pragma mark--receivedUdpMeg

-(void)didedReceiveMeg:(NSString*)meg
{
    NSLog(@"didedReceiveMeg--- %@",meg);
    NSString *shi=[meg substringToIndex:1];
    NSString *ge=[meg substringWithRange:NSMakeRange(1, 1)];
    shi=[self getShiJinZhiWith:shi];
    ge=[self getShiJinZhiWith:ge];
    int temp= [shi intValue]*16+[ge intValue];
    NSLog(@"hahah---%d",temp);
    [self updateData:temp];

    //[self showAlterView:[NSString stringWithFormat:@"%d",temp]];
}

-(void)showAlterView:(NSString *)str
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:str
                                                   delegate:self
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles:nil];
    [alert show];
    
    
    
    
}


#pragma mark--
#pragma mark--16进制转10进制
-(NSString*)getShiJinZhiWith:(NSString*)nummber
{
    if ([nummber isEqualToString:@"0"])
    {
        nummber=@"0";
    }
    else if ([nummber isEqualToString:@"1"])
    {
        nummber=@"1";
    } else if ([nummber isEqualToString:@"2"])
    {
        nummber=@"2";
    } else if ([nummber isEqualToString:@"3"])
    {
        nummber=@"3";
    } else if ([nummber isEqualToString:@"4"])
    {
        nummber=@"4";
    } else if ([nummber isEqualToString:@"5"])
    {
        nummber=@"5";
    }
    else if ([nummber isEqualToString:@"6"])
    {
        nummber=@"6";
    } else if ([nummber isEqualToString:@"7"])
    {
        nummber=@"7";
    } else if ([nummber isEqualToString:@"8"])
    {
        nummber=@"8";
    } else if ([nummber isEqualToString:@"9"])
    {
        nummber=@"9";
    }
    else if ([nummber isEqualToString:@"a"])
    {
        nummber=@"10";
    }
    else if ([nummber isEqualToString:@"b"])
    {
        nummber=@"11";
    }
    else if ([nummber isEqualToString:@"c"])
    {
        nummber=@"12";
    }
    else if ([nummber isEqualToString:@"d"])
    {
        nummber=@"13";
    }
    else if ([nummber isEqualToString:@"e"])
    {
        nummber=@"14";
    }
    else if ([nummber isEqualToString:@"f"])
    {
        nummber=@"15";
    }
    return nummber;
}




#pragma mark--
#pragma mrk--changeDay
-(void)changeDay
{
   [self removeAllWhewtherImageViewSubviews];
    NSString *date=nil;
    //HH 24小时制 ，hh 12小时制
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    date=[formatter stringFromDate:[NSDate date]];
    int time=[date intValue];
//    NSLog(@"当前时间formatter－－－－－%@",formatter);
//     NSLog(@"当前时间date－－－－－%@",date);
//    NSLog(@"time－－－－－%d",time);
    if (time >=18 || time<=06)
    {
        [self startView];
       self.navigationItem.rightBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"黑夜" style:UIBarButtonItemStylePlain target:nil action:nil];
          NSLog(@"黑夜");
//        [self makeLedView];
    }
   else
    {
        [self sunView];
        
     
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"白天" style:UIBarButtonItemStylePlain target:nil action:nil];
          NSLog(@"白天");

    }
    

}

#pragma mark--
#pragma mark--openLedButton

-(void)openLedButton
{
    _isLight=NO;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(230, 480, 90, 35)];
    [button setBackgroundImage:[UIImage imageNamed:@"w_xq1.png"] forState:UIControlStateNormal];
    [button setTitle:@"LED" forState:UIControlStateNormal];
    // button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}

-(void)open
{
   
    _isLight=!_isLight;
    if (_isLight==YES)
    {
        [self.model sendMassage:TurnON_LED IP:self.IP Port:self.port];
        self.ledView.hidden=NO;
        
    }
    else
    {
        [self.model sendMassage:TurnOFF_LED IP:self.IP Port:self.port];
        self.ledView.hidden=YES;

    }


}


#pragma mark--
#pragma mark--makeLedView
-(void)makeLedView
{
   self.ledView=[[LedView alloc]init];
    [self.view addSubview:  self.ledView];

}

#pragma mark--
#pragma mark--makeBigView

-(void)makeBigView
{
    
    self.bigImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    self.bigImageView.image=[UIImage imageNamed:@"w_bg.png"];
    [self.view addSubview:self.bigImageView];
    
    self.contentImageView=[[UIImageView alloc]init];
    self.contentImageView.center=CGPointMake(160, 235);
    self.contentImageView.bounds=CGRectMake(0, 0, 280, 291);
    [self.bigImageView addSubview:self.contentImageView];
    
    self.segControl=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"显示温度",@"关闭温度", nil]];
    //设置item 宽度
    [self.segControl setWidth:75.0 forSegmentAtIndex:0];
    [self.segControl setWidth:75.0 forSegmentAtIndex:1];
    //设置item style
        self.segControl.segmentedControlStyle=UISegmentedControlStyleBar;
    
    //[SegmentedControl setTitle:@"公共资源" forSegmentAtIndex:0];
    //[SegmentedControl setTitle:@"个人资源" forSegmentAtIndex:1];
    
    [self.segControl addTarget:self action:@selector(choseStatic:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView= self.segControl;

    



}

#pragma mark--
#pragma mark--choseStatic

-(void)choseStatic:(id)sender
{
    UISegmentedControl*control=(UISegmentedControl*)sender;
   
    switch (control.selectedSegmentIndex)
    {
        case 0:
        {
            [self openPage];
            [self configrWebView];
        }
            break;
        case 1:
        {
            [self closePage];
            
        }
            break;
            
        default:
            break;
    }
    


}

#pragma mark--
#pragma mark--sunView
-(void)sunView
{
    self.contentImageView.image=[UIImage imageNamed:@"w_duoyun.png"];
    SunView *sunView=[[SunView alloc]init];
    [self.contentImageView addSubview:sunView];
    CloudView *cloudView=[[CloudView alloc]init];
    [self.contentImageView addSubview:cloudView];
   
    



}

#pragma mark--
#pragma mark--startView

-(void)startView
{

    self.contentImageView.image=[UIImage imageNamed:@"w_night.png"];
    
    StartView *startView=[[StartView alloc]init];
    [self.contentImageView addSubview:startView];
}


-(void)removeAllWhewtherImageViewSubviews
{
    //subviews 所有子类  NSArray *wetherImageViewArray=[_weatherImageView subviews];
    //wetherImageViewArray 存放所有_weatherImageView的所有子视图
    NSArray *wetherImageViewArray=[self.contentImageView subviews];
    for (UIImageView * wetherImageView in wetherImageViewArray)
        
    {
        
        [wetherImageView removeFromSuperview];
    }
    
    
}
#pragma mark--
#pragma mark--configrWebView
-(void)configrWebView
{
    
    CGRect webFrame = self.view.frame;
    webFrame.origin.x = 0;
    webFrame.origin.y =  0;
    
    self.webViewForSelectDate = [[UIWebView alloc] initWithFrame:webFrame];
    self.webViewForSelectDate.delegate = self;
    self.webViewForSelectDate.scalesPageToFit = YES;
    self.webViewForSelectDate.opaque = NO;
    self.webViewForSelectDate.backgroundColor = [UIColor clearColor];
    self.webViewForSelectDate.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:self.webViewForSelectDate];
    
    //所有的资源都在source.bundle这个文件夹里
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/index.html"];
    NSLog(@"%@",htmlPath);
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webViewForSelectDate loadRequest:request];
    int trueWidth = self.view.frame.size.width;
    if (trueWidth < self.view.frame.size.height && ![UIApplication sharedApplication].statusBarHidden)
    {
        trueWidth = self.view.frame.size.height + MIN([UIApplication sharedApplication].statusBarFrame.size.height,[UIApplication sharedApplication].statusBarFrame.size.width);
    }

    self.lable=[[UILabel alloc]initWithFrame:CGRectMake(0, webFrame.size.height-100, 320, 40)];
    //self.lable.backgroundColor=[UIColor redColor];
    self.lable.textAlignment=NSTextAlignmentCenter;
    [self.webViewForSelectDate addSubview:self.lable];
    
    
//    NSString *lableStr=[NSString stringWithFormat:@"当前温度为：%d度",50];
//    self.lable.text=lableStr;

    
    //    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openPage)];
//    



}

#pragma mark--
#pragma mark--closePage
-(void)closePage
{
    self.webViewForSelectDate.hidden=YES;
//    //关闭定时器
//    [self.timer setFireDate:[NSDate distantFuture]];
//    //开启self.myTimer
//    [self.myTimer setFireDate:[NSDate distantPast]];
   

}
#pragma mark--
#pragma mark--openPage
-(void)openPage
{
    
     self.webViewForSelectDate.hidden=NO;
//    //开启定时器
//    [self.timer setFireDate:[NSDate distantPast]];

}

#pragma mark--
#pragma mark--更新温度
-(void)updateData:(int)temp
{
  
    //取得当前时间，x轴
    NSDate* nowDate = [[NSDate alloc]init];
   
    NSTimeInterval nowTimeInterval = [nowDate timeIntervalSince1970] * 1000;
 
   
    //随机温度，y轴
    
    //int temperature = [self getRandomNumber:20 to:80];
    int temperature= temp;
    
    NSMutableString* jsStr = [[NSMutableString alloc] initWithCapacity:0];
    [jsStr appendFormat:@"updateData(%f,%d)",nowTimeInterval,temperature];
    
    [self.webViewForSelectDate stringByEvaluatingJavaScriptFromString:jsStr];
    NSString *lableStr=[NSString stringWithFormat:@"当前温度为：%d度",temperature];
    self.lable.text=lableStr;
}
//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from  + (arc4random() % (to - from + 1)));
}
#pragma mark - delegate of webview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //等webview加载完毕再更新数据
//  self.timer = [NSTimer scheduledTimerWithTimeInterval: 1
//                                             target: self
//                                           selector: @selector(updateData)
//                                           userInfo: nil
//                                            repeats: YES];
}


//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

//-(void)makeNagView
//{
//
//    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    navView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:navView];
//    UISwitch *switchButton=[[UISwitch alloc]initWithFrame:CGRectMake(300, 10, 20, 10)];
//    [switchButton setOn:YES];
//    [switchButton addTarget:self action:@selector(closePage:) forControlEvents:UIControlEventValueChanged];
//    [navView addSubview:switchButton];
//
//
//
//}
//-(void)closePage:(id)sender
//{
//
//UISwitch *switchButton=(UISwitch*)sender;
//    BOOL isOn=[switchButton isOn];
//    if (isOn)
//    {
//        self.webViewForSelectDate.hidden=NO;
//    }
//    else
//    {
//     self.webViewForSelectDate.hidden=YES;
//    }
//
//
//}
//

@end
