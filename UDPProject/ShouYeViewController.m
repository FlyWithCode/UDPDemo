//
//  ShouYeViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/19.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "ShouYeViewController.h"
#import "FanViewController.h"
#import "WenDuViewController.h"
#import "CurtainViewController.h"
#import "BeginViewController.h"
#import "CollectionView.h"
#import "BackgroundView.h"
@interface ShouYeViewController ()

@end

@implementation ShouYeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"login.png"] forBarMetrics:UIBarMetricsDefault];
 
    self.title=@"首页";
    
   // self.view.backgroundColor=[UIColor redColor];
    BackgroundView *groundView=[[BackgroundView alloc]initWithFrame:self.view.frame];
    groundView.aImageView.image=[UIImage imageNamed:@"SIAS_5.jpg"];
   
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize=CGSizeMake(115, 100);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, 320, 568) collectionViewLayout:flowLayout];
   
    self.collectionView.backgroundView=groundView;
  
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

//设置一个分区中的 单元格数量
//必写
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 4;
}

//在这个方法里写 单元格的实现
//必写
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    单元格的初始化
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    CollectionView *cellView=[[CollectionView alloc]init];
    if (indexPath.row==0)
    {
        
          cellView.myLable.text=@"温度";
        cellView.myImageView.image=[UIImage imageNamed:@"wudu.jpg"];
    }
    else if (indexPath.row==1)
    {
         cellView.myLable.text=@"风扇";
        cellView.myImageView.image=[UIImage imageNamed:@"fengShan_01.jpg"];
    }
    else if (indexPath.row==2)
    {
         cellView.myLable.text=@"窗户";
        cellView.myImageView.image=[UIImage imageNamed:@"chuanhu.jpg"];
    }
    else if (indexPath.row==3)
    {
       cellView.myLable.text=@"设置";
        cellView.myImageView.image=[UIImage imageNamed:@"shezhi.jpg"];
    }

  
    cell.backgroundView=cellView;
    //cell.backgroundColor = [UIColor redColor];

    return cell;
    
}


#pragma mark -
#pragma mark UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

//选中某个 单元格后的响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---%ld---%ld",(long)indexPath.section,(long)indexPath.item);
    UIViewController *didSelectVC=nil;
    if (indexPath.row==0)
    {
        didSelectVC=[[WenDuViewController alloc]init];
       
       
    }
    else if (indexPath.row==1)
    {
       didSelectVC=[[FanViewController alloc]init];
    }
    else if (indexPath.row==2)
    {
        didSelectVC=[[CurtainViewController alloc]init];
    }
    else if (indexPath.row==3)
    {
         didSelectVC=[[BeginViewController  alloc]init];
    }
    [self addVCWith:didSelectVC];

}


#pragma mark--
#pragma mark--


-(void)addVCWith:(UIViewController*)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
    

}







@end
