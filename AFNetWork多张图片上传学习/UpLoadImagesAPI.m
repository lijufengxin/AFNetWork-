//
//  UpLoadImagesAPI.m
//  AFNetWork多张图片上传学习
//
//  Created by ll on 15/9/7.
//  Copyright (c) 2015年 Jintao. All rights reserved.
//

#import "UpLoadImagesAPI.h"
#import "AFNetworking.h"
#import "UpLoadImageHelper.h"
#define URL_UPLOADFILES @"上传图片的地址"
//生产环境

#define BASE_SERVERLURL @"http://123.57.84.153:8080/"
@interface UpLoadImagesAPI (p)
+(AFHTTPRequestOperationManager *)manager;
@end

@implementation UpLoadImagesAPI(p)

+(AFHTTPRequestOperationManager *)manager{
    static dispatch_once_t onceToken;
    static AFHTTPRequestOperationManager *_manager;
    dispatch_once(&onceToken, ^
                  {
                      _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_SERVERLURL]];
                  });
    return _manager;
}

@end
@implementation UpLoadImagesAPI


/**
 *  上传图片接口
 *
 */
+(void)uploadFile:(NSData *)fileData name:(NSString *)name   fileName:(NSString *)fileName mimeType:(NSString *)mimeType Success:(void (^)(id success))sucess fail:(void (^)(BOOL, NSString *))fail  {
    AFHTTPRequestOperationManager *manager = UpLoadImagesAPI.manager;
    /**
     *  根据需求这里设置响应方式和请求的header
     */
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    AFHTTPRequestOperation* op=[manager POST:URL_UPLOADFILES parameters:@{fileName:@"fileName"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (fileData!=nil) {
            [formData appendPartWithFileData :fileData name:name fileName:fileName mimeType:mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseString = (NSDictionary *)responseObject;
        NSLog(@"responseString:%@",responseString);
        if (responseObject) {
            int code=[[responseString objectForKey:@"code"] intValue];
            NSString *message=[responseString objectForKey:@"message"];
            if (code==1) {
                sucess(responseObject);
            }
            else if(code==501)
            {
                
            } else if(code==502)
            {       fail(NO,message);
               
            }
            else{
                fail(NO,message);
            }
        }else{
            fail(NO,@"服务器返回数据为空");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
        fail(YES,@"网络不给力");
    }];
    [op start];
}


/**
 *  上传多张图片接口
 *
 *  @param array      数据
 */
+(void)uploadManyFile:(NSArray *)array   Success:(void (^)(NSArray *success))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail {
    NSMutableArray *arrayUrl=[[NSMutableArray alloc]init];
    NSString *miniType=@"image/png";
    __block NSUInteger currentIndex=0;
    UpLoadImageHelper *uploadHelper=[UpLoadImageHelper sharedInstance];
    __weak UpLoadImageHelper *weakhelper=uploadHelper;
    weakhelper.singleFailureBlock=^(BOOL NotReachable,NSString *descript){
         fail(NO,@"服务器返回数据为空");
        
    };
    weakhelper.singleSuccessBlock=^(id success){
        //这里返回的数据需要解析哈一般的data里面的数据
        NSDictionary *dicdata=(NSDictionary *)success;
        NSArray *temparray=[dicdata objectForKey:@"data"];
        [arrayUrl addObject:temparray[0]];
        currentIndex++;
        if ([array count]==[arrayUrl count]) {
            sucess(arrayUrl);
            return ;
        }else{
            UIImage *imageone=array[currentIndex];
            NSData *imageData= UIImageJPEGRepresentation(imageone, 1.0);
             NSString *imagename=[NSString stringWithFormat:@"file%d",currentIndex];
            NSString *filename=[NSString stringWithFormat:@"file%d.png",currentIndex];
            
              [UpLoadImagesAPI uploadFile:imageData name:imagename fileName:filename mimeType:miniType Success:weakhelper.singleSuccessBlock fail:weakhelper.singleFailureBlock];
        }
        
        
        
    };
    UIImage *imageone=array[0];
    NSData *dataObj = UIImageJPEGRepresentation(imageone, 1.0);

    [UpLoadImagesAPI uploadFile:dataObj name:@"fileone" fileName:@"fileone.png" mimeType:miniType Success:weakhelper.singleSuccessBlock fail:weakhelper.singleFailureBlock];
    
    
}
@end
