//
//  UpLoadImagesAPI.h
//  AFNetWork多张图片上传学习
//
//  Created by ll on 15/9/7.
//  Copyright (c) 2015年 Jintao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpLoadImagesAPI : NSObject
/**
 *  上传文件接口
 *
 *  @param fileData      数据
 *  @param name          名称
 *  @param fileName      文件名称
 *  @param mimeType      文件类型
 */
+(void)uploadFile:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType Success:(void (^)(id sucess))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail ;

/**
 *  上传多张图片接口
 *
 *  @param array      数据
 */
+(void)uploadManyFile:(NSArray *)array   Success:(void (^)(NSArray *success))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail ;
@end
