//
//  SFJRecordTool.m
//  SFJRecordDemo
//
//  Created by 沙缚柩 on 2017/5/26.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "SFJRecordTool.h"

@implementation SFJRecordTool
static SFJRecordTool *tool = nil;
+ (instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (AVAudioRecorder *)recorderWithURL:(NSURL *)url{
    // 2.录音配置信息
    NSDictionary *info = @{
                           AVFormatIDKey : @(kAudioFormatLinearPCM), //定义文件的格式  wav
                           AVSampleRateKey : @1000, //采样率 11400, 32000, 8000
                           AVNumberOfChannelsKey : @2,
                           AVLinearPCMBitDepthKey : @8,
                           AVLinearPCMIsBigEndianKey : @NO,
                           AVLinearPCMIsFloatKey : @NO
                           };
    NSError *error = nil;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:info error:&error];
    if ([recorder prepareToRecord]) {
        [recorder record];
    }
    return recorder;
}

- (AVAudioPlayer *)playerWithURL:(NSURL *)url{
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (player) {
        player.volume = 1.0;
        [player prepareToPlay];
    }
    return player;
}

- (AVAudioPlayer *)playerWithData:(NSData *)data{
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data error: &error];
    if (player) {
        player.volume = 1.0;
        [player prepareToPlay];
    }
    return player;
}

// 配置会话
- (void)setAVAudioSession{
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

- (NSURL *)urlWithFileName:(NSString *)name{
    return [NSURL fileURLWithPath:[self pathWithFileName:name]];
}

- (NSString *)pathWithFileName:(NSString *)name{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [caches stringByAppendingPathComponent:name];
}


@end
