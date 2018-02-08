//
//  ViewController.h
//  UDPProject
//
//  Created by huhu on 15/12/17.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface ViewController : UIViewController
{
    NSMutableArray   *_lockNumberArray;
}
@property(nonatomic,strong) Model *model;
@end
