//
//  Model.m
//  UDPProject
//
//  Created by huhu on 15/12/17.
//  Copyright (c) 2015年 ShiYiChen. All rights reserved.
//

#import "Model.h"

@implementation Model

//建立基于UDP的Socket连接
-(void)openUDPServer
{
    //初始化udp
    AsyncUdpSocket *tempSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
    self.udpSocket=tempSocket;
    
    //绑定端口
    NSError *error = nil;
    [self.udpSocket bindToPort:8000 error:&error];
    
    //发送广播设置
    [self.udpSocket enableBroadcast:YES error:&error];
    
    //加入群里，能接收到群里其他客户端的消息
    [self.udpSocket joinMulticastGroup:@"224.0.0.2" error:&error];
    
   	//启动接收线程
    [self.udpSocket receiveWithTimeout:-1 tag:0];
    
}
////发送消息
//-(void)sendMessage_Click:(id)sender
//{
//    NSString *messageStr = @"hello";
//    [self sendMassage:messageStr];
//    
//    
//}
//通过UDP,发送消息
-(void)sendMassage:(NSString *)message IP:(NSString *)host Port:(UInt16)port
{
    
    // NSDate *nowTime = [NSDate date];
    
    NSMutableString *sendString=[NSMutableString stringWithCapacity:100];
    [sendString appendString:message];
    //开始发送 返回bool值
    BOOL res = [self.udpSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding]
                                 toHost:host
                                   port:port
                            withTimeout:-1
                
                                    tag:0];
//
//    if ([_delegate respondsToSelector:@selector(didedSendMeg:)]) {
//        [_delegate didedSendMeg:res];
//    }
    
    
    
   	if (!res) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"发送失败"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"发送的内容为:%@",sendString]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:nil];
        [alert show];
    
    
    }
    
    
    
    
}



#pragma mark--
#pragma mark--UdpSocketReceiveDataDelegate
/*
 - (BOOL)connectToHost:(NSString *)host onPort:(UInt16)port error:(NSError **)errPtr;
 - (BOOL)connectToAddress:(NSData *)remoteAddr error:(NSError **)errPtr;
 
 */

//接收成功
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
    //NSLog(@"接收成功-----udpClient");
    // NSError *error;
    //if ([host isEqualToString:@"192.168.9.221"])
    //{
    // BOOL isConcent=[sock connectToHost:host onPort:8000 error:&error];
    //if (isConcent==YES)
    // {
    //  NSLog(@"已经连接成功...");
    //  }
    //根据客户端给的ip,利用udp相互连接上就可以通讯了.
    
    // }
//    self.data=[[NSData alloc]init];
//    self.data=data;
//    
    NSString *result_now=(NSString*)data;
    NSString *now=[NSString stringWithFormat:@"%@",result_now];
    now=[now stringByReplacingOccurrencesOfString:@"" withString:@""];
    now=[now lowercaseString];
    now=[now substringToIndex:now.length-1];
    now=[now substringFromIndex:1];
    NSLog(@"data---%@",data);
    NSLog(@"接收：－－－%@",now);
//    int nowTemp=[now intValue];
//    NSLog(@"%d",nowTemp);
   // NSLog(@"sock---%@,data----%@,host---%@,port---%d",sock,data,host,port);
    
 
    if ([_delegate respondsToSelector:@selector(didedReceiveMeg:)]) {
        [_delegate didedReceiveMeg:now];
    }

    [self.udpSocket receiveWithTimeout:-1 tag:0];
    return YES;
}
//没有接收成功
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"没有接收成功%@",error);
    
}


#pragma mark -
#pragma mark UDPSendData Delegate Methods
- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    
    NSLog(@"发送成功.....");
    
}


//没有发送成功
- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    //无法发送时,返回的异常提示信息
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:[error description]
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}



#pragma mark--
#pragma mark--block
//-(void)didedSendMeg:(sendBlock)block
//{
//    block(self.isSucess);
//}
//-(void)didedReceiveMeg:(receiveBlock)block
//{
//
//    block(self.data);
//}


@end
