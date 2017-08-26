//
//  SFJRecordTool.m
//  SFJRecordDemo
//
//  Created by 沙缚柩 on 2017/5/26.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "SFJRecordTool.h"

@implementation SFJRecordTool

+ (AVAudioRecorder *)recorderWithURL:(NSURL *)url{
    // 2.录音配置信息
    NSDictionary *info = @{
                           AVFormatIDKey : @(kAudioFormatLinearPCM), //定义文件的格式  wav
//                           AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                           AVSampleRateKey : @8000, //采样率 11400, 32000, 8000
                           AVNumberOfChannelsKey : @2,
                           AVLinearPCMBitDepthKey : @16,
                           AVLinearPCMIsBigEndianKey : @NO,
                           AVLinearPCMIsFloatKey : @NO,
                           };
    NSError *error = nil;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:info error:&error];
    if ([recorder prepareToRecord]) {
        [recorder record];
    }
    return recorder;
}

+ (AVAudioPlayer *)playerWithURL:(NSURL *)url{
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (player) {
        player.volume = 1.0;
        [player prepareToPlay];
    }
    return player;
}

+ (AVAudioPlayer *)playerWithData:(NSData *)data{
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data error: &error];
    if (player) {
        player.volume = 1.0;
        [player prepareToPlay];
    }
    return player;
}

// 配置会话
+ (void)setAVAudioSession{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
    
    if(setCategoryError){
        NSLog(@"%@", [setCategoryError description]);
    }
    NSError *audioError = nil;
    BOOL success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&audioError];
    if(!success)
    {
        NSLog(@"error doing output audio port override - %@", [audioError localizedDescription]);
    }
}

+ (CGFloat)voiceDuarationWithURL:(NSURL *)url{
    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:url options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
}

// 获取语音文件长度
+ (CGFloat)voiceDuarationWithData:(NSData *)data{
    NSError *error = nil;
    AVAudioPlayer *audioPlayer =  [[AVAudioPlayer alloc] initWithData:data error:&error];
    float duration = (float)audioPlayer.duration;
    return duration;
}


+ (NSURL *)urlWithFileName:(NSString *)name{
    
    //    NSLog(@"file path %@",[self pathWithFileName:name]);
    return [NSURL fileURLWithPath:[self pathWithFileName:name]];
}

+ (NSString *)pathWithFileName:(NSString *)name{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [caches stringByAppendingPathComponent:name];
}

@end
