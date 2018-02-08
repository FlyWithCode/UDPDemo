//
//  FanView.h
//  UDPProject
//
//  Created by huhu on 15/12/21.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanView : UIView
@property(nonatomic,strong)UIImageView *fanImageView;
@property(nonatomic,assign)float number;
- (id)initWithFrame:(CGRect)frame :(float)number;
-(void)coludFly:(float)number;
@end
