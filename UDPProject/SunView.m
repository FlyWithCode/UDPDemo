
//
//  SunView.m
//  UDPProject
//
//  Created by huhu on 15/12/20.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "SunView.h"

@implementation SunView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.sunImageView=[[UIImageView alloc]init];
        self.sunImageView.center=CGPointMake(160, 100);
        self.sunImageView.bounds=CGRectMake(0, 0, 150, 150);
        self.sunImageView.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"w_sun1.png"],[UIImage  imageNamed:@"w_sun2.png"] ,nil];
        self.sunImageView.animationDuration=0.5;
         //sunImgView.animationRepeatCount = 0; 0代表无限的无穷大的
        self.sunImageView.animationRepeatCount=0;
        [self.sunImageView startAnimating];
        [self addSubview:self.sunImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
