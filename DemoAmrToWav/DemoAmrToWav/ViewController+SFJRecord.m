//
//  ViewController+SFJRecord.m
//  DemoAmrToWav
//
//  Created by 沙缚柩 on 2017/8/26.
//  Copyright © 2017年 ZhaoWei. All rights reserved.
//

#import "ViewController+SFJRecord.h"
#import "SFJRecordTool.h"
#import "SFJRcordAnimationView.h"

@implementation ViewController (SFJRecord)


- (void)setupVoicePlayer{
    self.voicePlayer.delegate = self;
}

- (void)setupRecordBtn{
    
    [self.recordBtn addTarget:self action:@selector(p_startRecord) forControlEvents:UIControlEventTouchDown];
    [self.recordBtn addTarget:self action:@selector(p_stopRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.recordBtn addTarget:self action:@selector(updateLabelForTouchDragExit) forControlEvents:UIControlEventTouchDragExit];
    [self.recordBtn addTarget:self action:@selector(upDateLabelForTouchDragEnter) forControlEvents:UIControlEventTouchDragEnter];
    [self.recordBtn addTarget:self action:@selector(p_cancelRecord) forControlEvents:UIControlEventTouchUpOutside];
}



- (NSURL *)fileUrl{
    return [SFJRecordTool urlWithFileName:@"record.wav"];
}

#pragma mark -
#pragma mark -  click event
// 开始录音
- (void)p_startRecord{
    recorder_ = [SFJRecordTool recorderWithURL:[self fileUrl]];
    
    // 开启音量检测
    recorder_.meteringEnabled = YES;
    [timer_ invalidate];
    // 准备录音
    if ([recorder_ prepareToRecord]) {
        // 开始录音
        [recorder_ record];
        timer_ = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.recordAnimView];
    [self.recordAnimView upDateLabelForTouchUpInside];
}
// 语音检测
-(void)detectionVoice
{
    [recorder_ updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder_ peakPowerForChannel:0]));
    //最大50  0
    [self.recordAnimView updateRecordAnimationByLowPassResults:lowPassResults];
}

// 结束录音
- (void)p_stopRecord{
    // 结束录音
    [recorder_ stop];
    recorder_ = nil;
    // 添加播放录音的按钮
    [timer_ invalidate];
    
    CGFloat voiceLength = [SFJRecordTool voiceDuarationWithURL:[self fileUrl]];
    if (voiceLength < 1) {
        NSLog(@"录音时间太短");
        return;
    }
    self.voicePlayer.duration = voiceLength;
    self.voicePlayer.hidden = NO;
    
    [self.recordAnimView removeFromSuperview];
}

// 取消录音
- (void)p_cancelRecord{
    [recorder_ stop];
    [recorder_ deleteRecording];
    [timer_ invalidate];
    
    self.voicePlayer.hidden = YES;
}

// 点击时候录音提示状态
- (void)upDateLabelForTouchDragEnter{
    [self.recordAnimView upDateLabelForTouchUpInside];
}

// 向上滑动时候录音提示状态
- (void)updateLabelForTouchDragExit{
    [self.recordAnimView updateLabelForTouchUpOutSide];
}

#pragma mark -
#pragma mark - <SFJVoicePlayerDelegate>
- (void)voicePlayerStartPalyVoice:(SFJVoicePlayer *)voicePlayer{
    
    NSData *data = [NSData dataWithContentsOfURL:[self fileUrl]];
    player_ = [SFJRecordTool  playerWithData:data];
    
    // voicePlayer 监听播放完成结束语音播放动画
    player_.delegate = voicePlayer;
    [player_ play];
}
@end
