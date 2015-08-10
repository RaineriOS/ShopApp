//
//  ClientSocket.h
//  OCModule
//
//  Created by shikee_app03 on 15-4-27.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

@interface ClientSocket : NSObject

-(void)createConnection;
+(ClientSocket*)shared;
-(void)sendMes:(char *)msg;
@end
