//
//  VoiceTypeTool.m
//  DemoAmrToWav
//
//  Created by ZhaoWei on 16/9/24.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//

#import "VoiceTypeTool.h"
#import "amrFileCodec.h"
@implementation VoiceTypeTool

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static VoiceTypeTool *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[VoiceTypeTool alloc] init];
    });
    return instance;
}

- (NSData *)amrToWav:(NSData *)amrData{
    
    return DecodeAMRToWAVE(amrData);
}

- (NSData *)wavToAmr:(NSData *)wavData{
    return [self wavToAmr:wavData channels:1 bitsPerSample:16];
}

/**
 wav格式转Amr

 @param wavData wav格式的数据
 @param nChannels 声道数
 @param nBitsPerSample 每样本的比特数，指的是编码的位宽。一般取值为8bit和16bit。
 @return 返回转换的wav格式的Data
 */
- (NSData *)wavToAmr:(NSData *)wavData channels:(int)nChannels bitsPerSample:(int )nBitsPerSample{
    return EncodeWAVEToAMR(wavData, nChannels, nBitsPerSample);
}
@end
