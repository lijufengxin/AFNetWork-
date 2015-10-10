//
//  ViewController.m
//  AFNetWork多张图片上传学习
//
//  Created by ll on 15/9/7.
//  Copyright (c) 2015年 Jintao. All rights reserved.
//

#import "ViewController.h"
#import "UpLoadImagesAPI.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"1"];
    UIImage *image2=[UIImage imageNamed:@"2"];
    NSArray *array=[NSArray arrayWithObjects:image,image2, nil];
    [UpLoadImagesAPI uploadManyFile:array Success:^(NSArray *success) {
        NSLog(@"%@",success);
    } fail:^(BOOL NotReachable, NSString *descript) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
