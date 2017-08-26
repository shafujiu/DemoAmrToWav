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
#import "SFJRcordAnimationView.h"
#import "ViewController+SFJRecord.h"

#define kScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define kScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

@interface ViewController ()
{
    
    NSData *amrData_;
    NSData *wavData_;
}

@end

@implementation ViewController

/** recordAnimView */
- (UIView *)recordAnimView{
    if (!_recordAnimView) {
        CGFloat width = 200;
        CGFloat height = width;
        CGFloat x = (kScreenWidth - width) / 2;
        CGFloat y = (kScreenHeight - height) / 2;
        _recordAnimView = [[SFJRcordAnimationView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    }
    return _recordAnimView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRecordBtn];
    [self setupVoicePlayer];
}

- (IBAction)wavToArm:(id)sender {
    
    NSData *data = [NSData dataWithContentsOfURL:[self fileUrl]];
    
//    NSLog(@"begin %@",[NSDate date]);
    amrData_ = [[VoiceTypeTool shareInstance] wavToAmr:data];
    _playTrsBtn.enabled = NO;
}

- (IBAction)armToWav:(id)sender {
    
     wavData_ = [[VoiceTypeTool shareInstance] amrToWav:amrData_];
    _playTrsBtn.enabled = YES;
}


- (IBAction)playTrans:(id)sender {
    player_ = [SFJRecordTool playerWithData:wavData_];
    [player_ play];
}


@end
