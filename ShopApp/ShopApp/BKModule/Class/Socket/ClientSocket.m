//
//  ClientSocket.m
//  OCModule
//
//  Created by shikee_app03 on 15-4-27.
//  Copyright (c) 2015年 shikee_app03. All rights reserved.
//

#import "ClientSocket.h"

@implementation ClientSocket
{
    int _sockfd;
    struct sockaddr_in _dest_addr; /* 目的地址*/
    
}

-(instancetype)init
{
    self=[super init];
    if(self){
        _sockfd=-2;
    }
    return self;
}

static ClientSocket* _shared;
+(ClientSocket*)shared{
    @synchronized(self){
        if(!_shared){
            _shared=[[ClientSocket alloc]init];
        }
        return _shared;
    }
}

-(void)createConnection
{
    
    /**
     CFIndex	version;
     void *	info;
     const void *(*retain)(const void *info);
     void	(*release)(const void *info);
     CFStringRef	(*copyDescription)(const void *info);
     */
//    int socketDes=socket(AF_INET, SOCK_STREAM  , 0);//创建一个socket,返回一个socket描述
//    struct sockaddr_in my_addr;
//    my_addr.sin_family=AF_INET;
//    my_addr.sin_port=htons(0);//随机端口
//    my_addr.sin_addr.s_addr=inet_addr(INADDR_ANY);//本机IP
//    int addrlen=sizeof(struct sockaddr_in);
//    bzero(&my_addr,addrlen);
//    bind(socketDes, (struct sockaddr *)&my_addr, sizeof(struct sockaddr));
    
    if(_sockfd==-2){
        bzero(&_dest_addr,sizeof(struct sockaddr_in));
        _sockfd = socket(AF_INET, SOCK_STREAM, 0); /* 错误检查 */
        _dest_addr.sin_family = AF_INET; /* host byte order */
        _dest_addr.sin_port = htons(8899); /* short, network byte order */
        _dest_addr.sin_addr.s_addr = inet_addr("192.168.61.220");
        /* zero the rest of the struct */
        int result=connect(_sockfd, (struct sockaddr *)&_dest_addr, sizeof(struct sockaddr));
//        char * msg= "testconnection!";
//        long bytes_sent=send(_sockfd, msg, strlen(msg), 0);
        [self recvMsg];
        errno;
        BKLog(@" result :  %i   ",result);
        BKLog(@"已经链接到服务器");
    }else {
        BKLog(@"已经链接过了~");
    }
    
}


-(void)sendMes:(char *)msg
{
    send(_sockfd, msg, strlen(msg), 0);
    NSString *string_content = [[NSString alloc] initWithCString:(const char*)msg
                                                        encoding:NSASCIIStringEncoding];
    BKLog(@"发出消息:%@",string_content);
}

-(void)recvMsg
{
    char *msg;
    long result=recv(_sockfd, msg, strlen(msg), 0);
    BKLog(@"接受成功%ld",result);
}


@end
