//
//  XYSViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "XYSViewController.h"
#import "FanViewController.h"
#import "WenDuViewController.h"
#import "CurtainViewController.h"
#import "OtherViewController.h"
@interface XYSViewController ()

@end

@implementation XYSViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    WenDuViewController *wenDuVC=[[WenDuViewController alloc]init];
    FanViewController *fanVC=[[FanViewController alloc]init];
   CurtainViewController *curtainVC=[[CurtainViewController alloc]init];
    OtherViewController *otherVC=[[OtherViewController alloc]init];
    
    NSString *mainSTR=@"main.png";
    NSString *mainSTR1=@"main@2x.png";
    [self addChildWithViewController:wenDuVC imageStr:mainSTR hightLightImageStr:mainSTR1 tababarTitle:@"温度"];
    [self addChildWithViewController:fanVC imageStr:mainSTR hightLightImageStr:mainSTR1 tababarTitle:@"风扇"];
    [self addChildWithViewController:curtainVC imageStr:mainSTR hightLightImageStr:mainSTR1 tababarTitle:@"窗帘"];
    
    [self addChildWithViewController:otherVC imageStr:mainSTR hightLightImageStr:mainSTR1 tababarTitle:@"其他"];
    

}

-(void)addChildWithViewController:(UIViewController *)childController imageStr:(NSString*)str hightLightImageStr:(NSString*) hightLightstr tababarTitle:(NSString*)titleStr
{
    
    childController.tabBarItem.image=[UIImage imageNamed: str];
    childController.tabBarItem.selectedImage=[UIImage imageNamed:hightLightstr];
    childController.tabBarItem.title=titleStr;
    //把传过来的childController包装到导航器里
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:childController];
    //把导航器放入tabarzhong
    [self addChildViewController:nav];
    
    
    
}

@end
