//
//  VoiceTypeTool.h
//  DemoAmrToWav
//
//  Created by ZhaoWei on 16/9/24.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//  安卓支持的是amr 格式 但是ios 并不支持，所以我们需要将语音格式由amr 转为ios 可识别的wav

#import <Foundation/Foundation.h>

@interface VoiceTypeTool : NSObject


+ (instancetype)shareInstance;
/**
 *  将传入的amr格式的二进制文件 转换为wav格式的二进制文件
 *
 *  @param amrData amr格式的文件
 *
 *  @return 转换后的wav二进制文件
 */
- (NSData *)amrToWav:(NSData *)amrData;

- (NSData *)wavToAmr:(NSData *)wavData;

@end
