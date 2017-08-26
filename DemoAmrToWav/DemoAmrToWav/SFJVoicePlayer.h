//
//  SFJVoicePlayer.h
//  SFJHusbandryAssistant
//
//  Created by 沙缚柩 on 2017/8/20.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class SFJVoicePlayer;

@protocol SFJVoicePlayerDelegate <NSObject>

- (void)voicePlayerStartPalyVoice:(SFJVoicePlayer *)voicePlayer;

@optional
- (void)voicePlayerDeleteBtnClicked:(SFJVoicePlayer *)voicePlayer;

@end

@interface SFJVoicePlayer : UIView<AVAudioPlayerDelegate>

/**
 声音文件（限制wav格式）
 */
//@property (nonatomic, strong) NSData *voiceData;

@property (nonatomic, weak) id<SFJVoicePlayerDelegate> delegate;

/**
 语音文件的长度（秒）
 */
@property (nonatomic, assign) CGFloat duration;

/**
 是否显示删除按钮
 */
@property (nonatomic, assign) BOOL showDelBtn;

/**
 开始录音播放动画
 */
- (void)startVoiceAnimating;

/**
 停止录音播放动画
 */
- (void)stopVoiceAnimating;

@end
