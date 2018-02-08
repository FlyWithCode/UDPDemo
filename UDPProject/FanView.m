//
//  FanView.m
//  UDPProject
//
//  Created by huhu on 15/12/21.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "FanView.h"

@implementation FanView

- (id)initWithFrame:(CGRect)frame :(float)number
{
    self = [super initWithFrame:frame];
    if (self)
   {
//         [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(coludFly) userInfo:nil repeats:YES ];
   
        [self coludFly:number];
        }
    return self;
}

-(void)coludFly:(float)number
{
    
   
    
    
    self.fanImageView=[[UIImageView alloc]init];
    self.fanImageView.image=[UIImage imageNamed:@"w_cloud.png"];
    self.fanImageView.frame=CGRectMake(0, 0, 320, 400);
    [self addSubview:self.fanImageView];
    
    self.fanImageView.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"fengShan_01.jpg"],[UIImage imageNamed:@"fengShan_02.jpg"],[UIImage imageNamed:@"fengShan_03.jpg"],[UIImage imageNamed:@"fengShan_04.jpg"],[UIImage imageNamed:@"fengShan_05.jpg"],[UIImage imageNamed:@"fengShan_06.jpg"],[UIImage imageNamed:@"fengShan_07.jpg"],[UIImage imageNamed:@"fengShan_08.jpg"],[UIImage imageNamed:@"fengShan_09.jpg"],[UIImage imageNamed:@"fengShan_10.jpg"],[UIImage imageNamed:@"fengShan_11.jpg"],[UIImage imageNamed:@"fengShan_12.jpg"],[UIImage imageNamed:@"fengShan_13.jpg"],[UIImage imageNamed:@"fengShan_14.jpg"],[UIImage imageNamed:@"fengShan_15.jpg"],[UIImage imageNamed:@"fengShan_16.jpg"],[UIImage imageNamed:@"fengShan_17.jpg"],[UIImage imageNamed:@"fengShan_18.jpg"],[UIImage imageNamed:@"fengShan_19.jpg"],[UIImage imageNamed:@"fengShan_20.jpg"],[UIImage imageNamed:@"fengShan_21.jpg"],[UIImage imageNamed:@"fengShan_22.jpg"],[UIImage imageNamed:@"fengShan_23.jpg"],[UIImage imageNamed:@"fengShan_24.jpg"],nil];
    
    
    
    self.fanImageView.animationDuration=number;
    self.fanImageView.animationRepeatCount=0;
    [self.fanImageView startAnimating];
    
    
    
    
}

@end
