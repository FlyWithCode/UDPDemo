//
//  BackgroundView.m
//  UDPProject
//
//  Created by huhu on 15/12/20.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // self.aImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)];
         self.aImageView=[[UIImageView alloc]initWithFrame:frame];
      
        [self addSubview:self.aImageView];
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
