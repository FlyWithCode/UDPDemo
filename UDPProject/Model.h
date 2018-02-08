//
//  Model.h
//  UDPProject
//
//  Created by huhu on 15/12/17.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncUdpSocket.h"
//typedef void(^sendBlock)(BOOL ret);
//typedef void(^receiveBlock)(NSData*data);
@interface Model : NSObject
@property (nonatomic, strong) AsyncUdpSocket*udpSocket;
@property(nonatomic,strong)NSData *data;
@property(nonatomic,assign)BOOL isSucess;
@property(unsafe_unretained)id delegate;
-(void)sendMassage:(NSString *)message IP:(NSString *)host Port:(UInt16)port;
-(void)openUDPServer;



//-(void)didedSendMeg:(sendBlock)block;
//-(void)didedReceiveMeg:(receiveBlock)block;
@end
@protocol ModelDelegate <NSObject>

//-(void)didedSendMeg:(BOOL)isSuccess;
-(void)didedReceiveMeg:(NSString*)meg;

@end