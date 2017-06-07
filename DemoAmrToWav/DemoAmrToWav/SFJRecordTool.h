//
//  SFJRecordTool.h
//  SFJRecordDemo
//
//  Created by 沙缚柩 on 2017/5/26.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>


@interface SFJRecordTool : NSObject

+ (instancetype)shareTool;
/**
     程序启动时，进行会话配置
 */
- (void)setAVAudioSession;

/**
 播放语音 每一次播放都是一个对象 创建一个AVAudioPlayer对象 并且播放语音
 
 @param url 本地的文件地址
 @return AVAudioPlayer 对象
 */
- (AVAudioPlayer *)playerWithURL:(NSURL *)url;

/**
 根据录音的Data播放

 @param data 录音数据
 @return AVAudioPlayer 对象
 */
- (AVAudioPlayer *)playerWithData:(NSData *)data;

/**
 录音 每一次录音都是一个新的AVAudioRecorder对象

 @param url 本地存储录音的地址，注意文件名需要.aac的后缀。如果需要修改格式，请移步到实现文件，info中的 AVFormatIDKey
 @return AVAudioRecorder录音对象
 */
- (AVAudioRecorder *)recorderWithURL:(NSURL *)url;

/**
 通过 沙盒的caches路径 + 文件名 创建本地文件路径的NSURL对象
 
 @param name 文件名
 @return URL对象
 */
- (NSURL *)urlWithFileName:(NSString *)name;

@end
