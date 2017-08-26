//
//  ViewController+SFJRecord.h
//  DemoAmrToWav
//
//  Created by 沙缚柩 on 2017/8/26.
//  Copyright © 2017年 ZhaoWei. All rights reserved.
//

#import "ViewController.h"
#import "SFJVoicePlayer.h"
@interface ViewController (SFJRecord)<SFJVoicePlayerDelegate>

- (void)setupVoicePlayer;

- (void)setupRecordBtn;

- (NSURL *)fileUrl;
@end
