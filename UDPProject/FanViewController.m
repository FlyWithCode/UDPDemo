//
//  FanViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "FanViewController.h"
#import "FanView.h"
#define TURNFAN_LOW  @"3" //51
#define TURNFAN_ZHONG @"4" //52
#define TURNFAN_HEIGHT @"5" //53
#define TURNFAN_OFF @"6"    //54
@interface FanViewController ()

@end

@implementation FanViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	
   
	
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"风扇";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(breakFan)];
    
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem  alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(  breakVC)];
    
    self.backImageV=[[UIImageView alloc]initWithFrame:self.view.frame];
    self.backImageV.backgroundColor=[UIColor redColor];
    self.backImageV.image=[UIImage imageNamed:@"sias_3.jpg"];
    [self.view addSubview:self.backImageV];
    
   self.IP=[[NSUserDefaults standardUserDefaults]objectForKey:@"IP"];
   self.port=[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"port"]] intValue];
       NSLog(@"ip:%@ port:%d",self.IP ,self.port);
      self.model=[[Model alloc]init];
    self.model.delegate=self;
    [self.model openUDPServer];
   
    NSArray *array=[NSArray arrayWithObjects:@"低",@"中",@"高", nil];
    for (int i=0; i<3; i++)
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(i*100+15, 510, 90, 60)];
        [button setBackgroundImage:[UIImage imageNamed:@"w_xq1.png"] forState:UIControlStateNormal];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
       // button.backgroundColor=[UIColor redColor];
        [button addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i+1;
        [self.view addSubview:button];
    }
    
    
    
    
}

-(void)breakVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.model.udpSocket close];

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




#pragma mark--
#pragma mark--breakFan
-(void)breakFan
{
    
    [self.model sendMassage:TURNFAN_OFF IP:self.IP Port:self.port];
    //[self showAlterView:TURNFAN_OFF];

    NSLog(@"breakFan");
    //[self.fanView.fanImageView removeFromSuperview];
    
   NSArray *allImageView=[self.fanView  subviews];
    for (UIImageView *imageView in allImageView)
   {
        [imageView removeFromSuperview];
   }

   self.backImageV.hidden=NO;


}




#pragma mark--
#pragma mark--open
-(void)open:(id)sender
{
    NSArray *allImageView=[self.fanView  subviews];
    for (UIImageView *imageView in allImageView)
    {
        [imageView removeFromSuperview];
    }

    UIButton *button=(UIButton*)sender;
    int tag =button.tag;
    switch (tag) {
        case 1:
        {
            [self openFan:0];
             [self.model sendMassage:TURNFAN_LOW IP:self.IP Port:self.port];
            //[self showAlterView:TURNFAN_LOW];
        }
            break;
        case 2:
        {
            [self openFan:0.4];
             [self.model sendMassage:TURNFAN_ZHONG IP:self.IP Port:self.port];
           // [self showAlterView:TURNFAN_ZHONG ];

        }
            break;
        case 3:
        {
            [self openFan:0.2];
             [self.model sendMassage:TURNFAN_HEIGHT IP:self.IP Port:self.port];
            //[self showAlterView:TURNFAN_HEIGHT];
        }
            break;
        default:
            break;
    }
    
}


#pragma mark--
#pragma mark--alterView提示

-(void)showAlterView:(NSString *)str
{
  
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
     message:str
     delegate:self
     cancelButtonTitle:@"ok"
     otherButtonTitles:nil];
     [alert show];
     
    


}

-(void)openFan:(float)number
{
    self.backImageV.hidden=YES;
    self.fanView=[[FanView alloc]initWithFrame:CGRectMake(0, 0, 320, 450) :number];
    [self.view addSubview:self.fanView];


}


@end
