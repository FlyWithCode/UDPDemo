//
//  LockButton.h
//  UDPProject
//
//  Created by huhu on 15/12/18.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockButton : UIButton
{
    //Cover 覆盖
    //记录当前这个按钮有没有被覆盖
    //黄色按钮创建的时候，还有绿色按钮创建的时候，类型都是ZYButton，对于黄色的按钮，我们可以通过这个属性来判断，这个按钮上面有没有数字，对于绿色的按钮我们能通过这个属性来判断，这个按钮有没有飞上去。
    BOOL          _isCoverd;
    //记录按钮的原始位置
    CGPoint       _originalCenter;
    
    //主要是绿色按钮用这个属性，绿色按钮设置属性，来存储他对应的黄色按钮
    LockButton      *_coupleButton;
    
    //表示黄色按钮有没有和绿色按钮数字匹配上
    BOOL          _isPaired;
}



@property LockButton      *coupleButton;
@property BOOL          isCoverd;
@property BOOL          isPaired;
@property CGPoint       originalCenter;

@end
