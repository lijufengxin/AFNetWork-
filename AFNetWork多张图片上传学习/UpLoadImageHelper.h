//
//  UpLoadImageHelper.h
//  AFNetWork多张图片上传学习
//
//  Created by ll on 15/9/7.
//  Copyright (c) 2015年 Jintao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpLoadImageHelper : NSObject
@property (copy, nonatomic) void (^singleSuccessBlock)(id success);
@property (copy, nonatomic)  void (^singleFailureBlock)(BOOL NotReachable,NSString *descript);

+ (instancetype)sharedInstance;
@end
