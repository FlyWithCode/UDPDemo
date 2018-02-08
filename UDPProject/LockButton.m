//
//  LockButton.m
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "LockButton.h"

@implementation LockButton

@synthesize isCoverd = _isCoverd;
@synthesize originalCenter = _originalCenter;
@synthesize coupleButton = _coupleButton;
@synthesize isPaired = _isPaired;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
