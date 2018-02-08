//
//  LedView.m
//  UDPProject
//
//  Created by huhu on 15/12/22.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "LedView.h"

@implementation LedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        self.ledImageView=[[UIImageView alloc]init];
        self.ledImageView.frame=CGRectMake(100, 380, 100, 100);
        self.ledImageView.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"led_1.png"],[UIImage  imageNamed:@"led_2.png"] ,nil];
        self.ledImageView.animationDuration=0.5;
        //sunImgView.animationRepeatCount = 0; 0代表无限的无穷大的
        self.ledImageView.animationRepeatCount=0;
        [self.ledImageView startAnimating];
        [self addSubview:self.ledImageView];
        
        
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
