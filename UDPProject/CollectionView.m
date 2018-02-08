//
//  CollectionView.m
//  UDPProject
//
//  Created by huhu on 15/12/20.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 115,80)];
        self.myImageView.backgroundColor=[UIColor clearColor];
        [self addSubview:self.myImageView];
        self.myLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 115, 20)];
        self.myLable.backgroundColor=[UIColor clearColor];
        [self addSubview:self.myLable];
        
    
    
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
