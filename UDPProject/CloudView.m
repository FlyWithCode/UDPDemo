//
//  CloudView.m
//  UDPProject
//
//  Created by huhu on 15/12/20.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "CloudView.h"

@implementation CloudView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(coludFly) userInfo:nil repeats:YES ];
    
    
    }
    return self;
}


-(void)coludFly
{

   int i=arc4random()%40+60;
    
    
    self.cloundImageView=[[UIImageView alloc]init];
    self.cloundImageView.image=[UIImage imageNamed:@"w_cloud.png"];
    self.cloundImageView.frame=CGRectMake(321,i, 118, 60);
    [self addSubview:self.cloundImageView];
    
    [UIView beginAnimations:nil context:nil ];
    [UIView setAnimationDuration:3];
    
    self.cloundImageView.frame=CGRectMake(-300,i, 118,60);
    
    [UIView commitAnimations];



}


@end
