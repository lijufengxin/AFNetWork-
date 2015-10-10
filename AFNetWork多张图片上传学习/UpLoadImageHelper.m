//
//  UpLoadImageHelper.m
//  AFNetWork多张图片上传学习
//
//  Created by ll on 15/9/7.
//  Copyright (c) 2015年 Jintao. All rights reserved.
//

#import "UpLoadImageHelper.h"

@implementation UpLoadImageHelper
+ (instancetype)sharedInstance{
    static UpLoadImageHelper *sharedInstance=nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance=[[UpLoadImageHelper alloc]init];
    });
    return sharedInstance;
}
@end
