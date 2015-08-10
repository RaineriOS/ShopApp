/**=============== 日志系统 v1.0 ==================
    Kiang 2015-05-05 17:17:13

    当本地日志积累到一定程度的时候，自动上传到服务器上
   ==============================================
*/

#import <Foundation/Foundation.h>



#define XLogName @"/zhs_log.txt"  //日志文件名，前面必须带斜杠。
#define XLogMaxCount 20           //日志允许最大写入行数,当超过这个行数的时候将会自动上传到服务器,并清空原日志文件

#define XLogPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject] stringByAppendingString:XLogName] //日志完整IPhone沙盒地址

#define XLogUploadUrl @"http://192.168.61.220:8080/RobotProject/UploadAction"  //服务器上传地址 ， 自定义

@interface XLog : NSObject
+(id)shared;
-(NSData *)getXLogData;         //获取日志文件二进制数据
-(NSString *)getXLogContent;    //获取日志内容
-(NSInteger)getXLogCount;       //获取日志当前占用行数
-(void)error:(NSString *)msg;   //写入错误消息到日志
-(void)info:(NSString *)msg;    //写入条数消息到日志
@end
