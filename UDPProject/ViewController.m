//
//  ViewController.m
//  UDPProject
//
//  Created by huhu on 15/12/17.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "ViewController.h"
#import "LockButton.h"
#import "ShouYeViewController.h"


//按钮离屏幕边缘的距离
#define NUMBER_BOARDER_WHITE_SPACE          10

//锁定按钮离屏幕上方的距离
#define LOCK_NUMBER_Y_OFFSET                130
//锁定按钮的宽度
#define LOCK_NUMBER_BUTTON_WIDTH            55

//输入按钮离屏幕上方的距离
#define TYPE_NUMBER_Y_OFFSET                280
//输入按钮的宽度
#define TYPE_NUMBER_BUTTON_WIDTH            45


@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
//    
//    self.model=[[Model alloc]init];
//    [self.model openUDPServer];
	
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _lockNumberArray = [[NSMutableArray alloc] init];
    
   UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    backgroundImageView.backgroundColor=[UIColor blueColor];
    //图片名字加不加@2x都可以，系统发现是高清屏，会自动查找对应的@2x的图片
    backgroundImageView.image = [UIImage imageNamed:@"SIAS_5.jpg"];
    [self.view addSubview:backgroundImageView];
    
    //创建一个数组，数组中放了[0,9]的十个字符串
    NSMutableArray *numberArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
    {
        [numberArray addObject:[[NSString alloc] initWithFormat:@"b_%d.png",i]];
    }
    
    //计算每个按钮横向之间的距离
    //（屏幕的宽度 - 2倍的边距 - 4倍的按钮宽度） / 3
    int lockButtonMargin = (self.view.frame.size.width - 2 * NUMBER_BOARDER_WHITE_SPACE - 4 * LOCK_NUMBER_BUTTON_WIDTH ) / 3;
    for (int i = 0 ; i < 4; i++)
    {
        LockButton *button = [[LockButton alloc] init];
        //tag不能从0开始，因为tag的默认值是0
        button.tag = i + 1;
        
        //x = 边距 + i * 按钮的宽度 + i * 按钮间距
        int x =  NUMBER_BOARDER_WHITE_SPACE + i * (LOCK_NUMBER_BUTTON_WIDTH + lockButtonMargin);
        //y 是一个固定值
        int y = LOCK_NUMBER_Y_OFFSET;
        
        button.frame = CGRectMake(x, y, LOCK_NUMBER_BUTTON_WIDTH, LOCK_NUMBER_BUTTON_WIDTH);
        
        //随机一个数字，范围是[0,9],并不是因为图片是从b0到b9，而是因为numberArray 这个数组的索引是[0,9]
        //因为数组每次随机后要删除一个元素，所以随机出来的数字范围，每次减少一个
        int randomIndex = arc4random() % (10 - i);
        
        //拿到随机的索引，去数组中取得对应位置的图片名字
        NSString *imageName = [numberArray objectAtIndex:randomIndex];
        
        //b_x.png  Separated  分割  component 元素
        //通过分割图片名字的方法，把图片中的数字序号给取出来，然后把数字存到_lockNumberArray中，这样我们就把随机出来的四个数字依次存了起来，便于以后我们知道黄色按钮上的具体数字
        //componentsSeparatedByString 这是一个NSString的方法，作用是通过一个符号把字符串分割成一个数组，数组中由分割出来的元素组成。
        NSString *numberString = [[[[imageName componentsSeparatedByString:@"."] objectAtIndex:0] componentsSeparatedByString:@"_"] objectAtIndex:1];
        [_lockNumberArray addObject:numberString];
        
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        //数组中的这个数字已经取过，为了保证不重复，所以把这个对应位置上的数字从数组中删除，这样下次就不可能取到相同的数字
        [numberArray removeObjectAtIndex:randomIndex];
        
        [self.view addSubview:button];
    }
    
    //计算绿色按钮之间的间隔
    int typeButtonMargin = (self.view.frame.size.width - 2 * NUMBER_BOARDER_WHITE_SPACE - 5 * TYPE_NUMBER_BUTTON_WIDTH ) / 4;
    for (int i = 0 ; i < 10; i++)
    {
        LockButton *button = [[LockButton alloc] init];
        //不能是i+1，因为上面四个按钮的tag已经是[1,4]
        button.tag = i + 5;
        [button addTarget:self action:@selector(typeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        int x =  NUMBER_BOARDER_WHITE_SPACE + i % 5 * (TYPE_NUMBER_BUTTON_WIDTH + typeButtonMargin);
        int y = TYPE_NUMBER_Y_OFFSET + ( i / 5 ) * 60;
        
        button.frame = CGRectMake(x, y, TYPE_NUMBER_BUTTON_WIDTH, TYPE_NUMBER_BUTTON_WIDTH);
        //把button的初始位置赋给originalCenter，以备将来做返回动画的时候，知道他的原始位置
        button.originalCenter = button.center;
        
        
        NSString *imageName = [[NSString alloc] initWithFormat:@"s_%d.png",i];
        
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }

	
}
//绿色按钮点击方法
- (void)typeButtonClicked:(id)sender
{
    //点击的绿色按钮对象
    LockButton *button = (LockButton *)sender;
    
    //判断点击的这个绿色按钮是否已经是飞上去的状态
    if (button.isCoverd == YES)
    {
        //飞下去之后，重新更改绿色按钮和黄色按钮的isCoverd属性，改为未覆盖
        button.isCoverd = NO;
        button.coupleButton.isCoverd = NO;
        //黄色按钮已飞下去，所以需要把黄色按钮数字是否对应的属性设置为NO
        button.coupleButton.isPaired = NO;
        
        [UIView beginAnimations:nil  context:nil];
        [UIView setAnimationDuration:2];
        button.center = button.originalCenter;
        [UIView commitAnimations];
        
        //如果是飞下去，就不再执行后面飞上来的代码逻辑了
        return;
    }
    
    //当绿色按钮点击的时候，我们遍历一下黄色的按钮，从前往后，看一下哪个黄色的按钮还没有被数字覆盖
    for (int i = 0 ; i < 4; i++)
    {
        LockButton *lockButton = (LockButton *)[self.view viewWithTag:i + 1];
        if (lockButton.isCoverd == NO)
        {
            
            //把绿色按钮的覆盖属性改为YES，证明绿色这个按钮已经飞上去了，已经有主了，是为了点击这个按钮的时候，判断他是要飞上去还是飞下来
            button.isCoverd = YES;
            //黄色按钮也改为已经覆盖的状态
            //不能再动画结束的时候才去更改这两个状态，不然当动画还没结束的时候，再去点击另外一个绿色按钮，这个绿色的按钮还会飞向这个黄色的按钮
            lockButton.isCoverd = YES;
            
            //绿色按钮的数字
            int greenNumber = button.tag - 5;
            int yellowNumber = [[_lockNumberArray objectAtIndex:lockButton.tag - 1] intValue];
            //如果绿色按钮的数字和黄色按钮的数字匹配
            if (greenNumber == yellowNumber)
            {
                //把黄色按钮的是否数字对应属性改为YES
                lockButton.isPaired = YES;
            }
            
            
            //在绿色按钮中存储他所对应的黄色按钮，将来飞下来的过程中，可以找到对应的黄色按钮，并且把他的isCoverd属性改为NO
            button.coupleButton = lockButton;
            
            [UIView beginAnimations:nil  context:nil];
            [UIView setAnimationDuration:2];
            
            //在飞上去的动画结束的方法中，去判断这是不是最后一个飞上去的按钮
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            
            //做动画，让绿色按钮和找到没有被覆盖的黄色按钮的中心重叠
            //不要使用frame，因为两个按钮大小不一样，你需要计算左上角的坐标
            button.center = lockButton.center;
            
            [UIView commitAnimations];
            //绿色按钮已经找到一个主了，不再找其他的黄色按钮了
            break;
        }
    }
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    
    BOOL isAllCoupled = YES;
    BOOL isALLPaired = YES;
    
    //判断每个黄色按钮是否被覆盖
    for (int i = 0 ; i < 4; i++)
    {
        LockButton *lockButton = (LockButton *)[self.view viewWithTag:i + 1];
        if (lockButton.isCoverd == NO)
        {
            isAllCoupled = NO;
        }
        if (lockButton.isPaired == NO)
        {
            isALLPaired = NO;
        }
    }
    
    //如果for循环完成之后isAllCoupled值还是YES，就证明没有进入if (lockButton.isCoverd == NO) 这个判断，没有进这个判断，就证明四个黄色按钮的isCoverd都不是NO，都不是NO，就证明全部被覆盖
    //证明全部被覆盖，应该进一步判断数字有没有全部对应上
    if (isAllCoupled == YES && isALLPaired == YES)
    {
        NSLog(@"全部覆盖并且全部匹配");
        self.view.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:[ShouYeViewController new]];
            }
    
    
}

@end
