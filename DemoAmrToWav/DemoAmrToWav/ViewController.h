//
//  ViewController.h
//  DemoAmrToWav
//
//  Created by ZhaoWei on 16/9/24.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class SFJRcordAnimationView;
@class SFJVoicePlayer;

@interface ViewController : UIViewController
{
    NSTimer *timer_;    // 检测录音音频的定时器
    
    AVAudioPlayer *player_;
    AVAudioRecorder *recorder_;
}


@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
/** 录音输入检测 */
@property (nonatomic, strong) SFJRcordAnimationView *recordAnimView;
@property (weak, nonatomic) IBOutlet SFJVoicePlayer *voicePlayer;

@property (weak, nonatomic) IBOutlet UIButton *playTrsBtn;
@end

