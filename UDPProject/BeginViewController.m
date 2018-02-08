//
//  BeginViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "BeginViewController.h"
#import "ShouYeViewController.h"
@interface BeginViewController ()

@end

@implementation BeginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cofigurView];
}

-(void)cofigurView
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.backgroundColor=[UIColor blueColor];
    imageView.image=[UIImage imageNamed:@"sias_2.jpg" ];
    [self.view addSubview:imageView];
    
    NSArray *textArray=[[NSArray alloc]initWithObjects:@"请输入您的IP",@"请输入您的port" ,nil];
    for (int i=0; i<2; i++)
    {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(i *150+12, 100, 130, 30)];
        textField.backgroundColor=[UIColor whiteColor];
        textField.placeholder=[textArray objectAtIndex:i];
        textField.tag=i+1;
        [self.view addSubview:textField];
        
    }
    
    //UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(0, 420, 320, 60)];
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(0, 494, 375, 80)];
   // but.backgroundColor=[UIColor redColor];
    [but setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [but setTitle:@"保存" forState:UIControlStateNormal];
    [but setTitleEdgeInsets:UIEdgeInsetsMake(30, 150, 30, 150)];
//    but.titleLabel.text=@"保存";
//    but.titleLabel.textAlignment=NSTextAlignmentCenter;
    [but addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    
    
    
    
    
}
//发送消息
-(void)buttonClick
{
    NSLog(@"buttonClick");
    UITextField *IPTextField=(UITextField*)[self.view viewWithTag:1];
    UITextField *portTextField=(UITextField*)[self.view viewWithTag:2];
   
    
    if (IPTextField.text.length==0 & portTextField.text.length==0)
    {
        UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"IP和Potr不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }
    else
    {
       
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        [userDefault setObject:IPTextField.text forKey:@"IP"];
        [userDefault setObject:portTextField.text  forKey:@"port"];
        
        
    }
    
    
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.window endEditing:YES];
    
    
}

@end
