//
//  CurtainViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "CurtainViewController.h"
#define CHUSHI_HEIGHT 65

#define TURN_CURRTEN_ON @"7" //55

#define TURN_CURRTEN_STOP @"8" //56

#define TURN_CURRTEN_OFF @"9" //57

@interface CurtainViewController ()

@end

@implementation CurtainViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	
   	
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _height=CHUSHI_HEIGHT ;
    self.navigationItem.title=@"窗户";
    self.view.backgroundColor=[UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"暂停" style:UIBarButtonItemStylePlain target:self action:@selector(breakCurtain:)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(  breakVC)];
    
    self.backImageV=[[UIImageView alloc]initWithFrame:self.view.frame];
    self.backImageV.backgroundColor=[UIColor redColor];
    self.backImageV.image=[UIImage imageNamed:@"sias_4.jpg"];
    [self.view addSubview:self.backImageV];
    //curtainImageV
    self.curtainImageV=[[UIImageView alloc]init];
    self.curtainImageV.backgroundColor=[UIColor redColor];
    self.curtainImageV.image=[UIImage imageNamed:@"curtain_1.png"];
    [self.backImageV addSubview:self.curtainImageV];

   
    [self changeCurtainImageVIew:CHUSHI_HEIGHT];
    [self openCurtainButton];
    [self closeCurtainButton];
    
    self.IP=[[NSUserDefaults standardUserDefaults]objectForKey:@"IP"];
    self.port=[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"port"]] intValue];
    
    NSLog(@"ip:%@ port:%d", self.IP,self.port);
    self.model=[[Model alloc]init];
    self.model.delegate=self;
    [self.model openUDPServer];
   
    
    
    
    
}

-(void)breakVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.model.udpSocket close];
    [self.closeTimer invalidate];
    [self.openTimer invalidate];
    NSLog(@"视图已经消失－－－－");
    
    
}

#pragma mark--
#pragma mark--receivedUdpMeg

-(void)didedReceiveMeg:(NSString*)meg
{
    NSLog(@"didedReceiveMeg %@",meg);
    self.udpReceiveMeg=meg;
    
}

//#pragma mark--
//#pragma mark--sendedUdpMeg
//-(void)didedSendMeg:(BOOL)isSuccess
//{
//    
//    NSLog(@"%hhd",isSuccess);
//    
//    
//}
//


#pragma mark--
#pragma mark--changeCurtainImageVIew
-(void)changeCurtainImageVIew:(float)height
{
    self.curtainImageV.frame=CGRectMake(0, 0, 320, height);

}

-(void)openCurtainButton
{

    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(230, 530, 90, 35)];
    [button setBackgroundImage:[UIImage imageNamed:@"w_xq1.png"] forState:UIControlStateNormal];
    [button setTitle:@"UP" forState:UIControlStateNormal];
    // button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];


}
-(void)closeCurtainButton
{
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 530, 90, 35)];
    [button setBackgroundImage:[UIImage imageNamed:@"w_xq1.png"] forState:UIControlStateNormal];
    [button setTitle:@"DOWN" forState:UIControlStateNormal];
    // button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}
#pragma mark--
#pragma mark--close
-(void)close
{
    [self changeCurtainImageVIew:_height];
    [self.openTimer invalidate];
    self.closeTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downHeight) userInfo:nil repeats:YES];
     [self.model sendMassage:TURN_CURRTEN_OFF IP:self.IP Port:self.port];
}

-(void)downHeight
{
    
    _height=_height-13;
    [self changeCurtainImageVIew:_height];
    NSLog(@"downHeight---_height----%f",_height);
    if (_height==CHUSHI_HEIGHT)
    {
        [self.closeTimer invalidate];
    }
    
    
    
    
}

#pragma mark--
#pragma mark--open
-(void)open
{
    
    [self changeCurtainImageVIew:_height];
    [self.closeTimer invalidate];
    self.openTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(upHeight) userInfo:nil repeats:YES];
    [self.model sendMassage:TURN_CURRTEN_ON IP:self.IP Port:self.port];
}

-(void)upHeight
{
    _height=_height+13;
    [self changeCurtainImageVIew:_height];
    NSLog(@"upHeight---_height-----%f",_height);
    if (_height==455)
    {
        [self.openTimer invalidate];
    }
    

    

}
#pragma mark--
#pragma mark--breakCurtain
-(void)breakCurtain:(id)sender
{
     [self.model sendMassage:TURN_CURRTEN_STOP IP:self.IP Port:self.port];
    [self.openTimer invalidate];
    [self.closeTimer invalidate];
    
    [self changeCurtainImageVIew:_height];
    
}

@end
