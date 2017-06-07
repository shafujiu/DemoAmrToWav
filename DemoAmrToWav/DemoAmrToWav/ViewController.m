//
//  ViewController.m
//  DemoAmrToWav
//
//  Created by ZhaoWei on 16/9/24.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//

#import "ViewController.h"
#import "VoiceTypeTool.h"
#import <AVFoundation/AVFoundation.h>

#import "SFJRecordTool.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AVAudioPlayer *player_;
    AVAudioRecorder *recorder_;
    NSData *amrData_;
    NSData *wavData_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)play:(id)sender {
    
}

- (IBAction)start:(id)sender {
    
    recorder_ = [[SFJRecordTool shareTool] recorderWithURL:[self fileUrl]];
}

- (IBAction)stop:(id)sender {
    [recorder_ stop];
   
}

- (IBAction)wavToArm:(id)sender {
    
    NSData *data = [NSData dataWithContentsOfURL:[self fileUrl]];
    amrData_ = [[VoiceTypeTool shareInstance] wavToAmr:data];
}

- (IBAction)armToWav:(id)sender {
    
     wavData_ = [[VoiceTypeTool shareInstance] amrToWav:amrData_];
}

- (IBAction)playOrl:(id)sender {
    NSData *data = [NSData dataWithContentsOfURL:[self fileUrl]];
    player_ = [[SFJRecordTool shareTool] playerWithData:data];
        [player_ play];
    
}

- (IBAction)playTrans:(id)sender {
    
    player_ = [[SFJRecordTool shareTool] playerWithData:wavData_];
//    if ([player_ isPlaying]){
        [player_ play];
    
}

- (NSURL *)fileUrl{
    return [[SFJRecordTool shareTool] urlWithFileName:@"record.wav"];
}



@end
