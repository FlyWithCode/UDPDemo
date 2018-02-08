//
//  StartView.m
//  UDPProject
//
//  Created by huhu on 15/12/20.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "StartView.h"

@implementation StartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        for (int i=0; i<20; i++) {
            
            UIImageView *starImageView =[[UIImageView alloc]init];
            starImageView.center=CGPointMake(arc4random()%261+10, arc4random()%100) ;
            starImageView.bounds=CGRectMake(0, 0, 20, 20)  ;                                   starImageView.animationImages=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"xx2.png"],[UIImage imageNamed:@"xx1.png"], nil];
            starImageView.animationDuration=0.5;
            starImageView.animationRepeatCount=0;
            [starImageView startAnimating];
            [self addSubview:starImageView];
            
            
        }
        
        for (int i=0; i<10; i++) {
            UIImageView *starImageView =[[UIImageView alloc]init];
            starImageView.center=CGPointMake(arc4random()%321+5, arc4random()%150) ;
            starImageView.bounds=CGRectMake(0, 0, 30, 30)  ;                                   starImageView.animationImages=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"xx2.png"],[UIImage imageNamed:@"xx1.png"], nil];
            starImageView.animationDuration=0.5;
            starImageView.animationRepeatCount=0;
            [starImageView startAnimating];
            [self addSubview:starImageView];
            
            
            
            
        }
        
        
        UIImageView *starImageView=[[UIImageView alloc]init];
        starImageView.center=CGPointMake(150 ,90 ) ;
        starImageView.bounds=CGRectMake(0, 0, 150,88);
        starImageView.animationImages=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"w_moon2.png"],[UIImage imageNamed:@"w_moon1.png"], nil];
        starImageView.animationDuration=0.5;
        starImageView.animationRepeatCount=0;
        [starImageView startAnimating];
        [self addSubview:starImageView];
        

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
