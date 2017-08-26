//
//  SFJVoicePlayer.m
//  SFJHusbandryAssistant
//
//  Created by 沙缚柩 on 2017/8/20.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "SFJVoicePlayer.h"

@interface SFJVoicePlayer()

@property (weak, nonatomic) IBOutlet UIImageView *voiceBg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *voiceIcon;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@end

@implementation SFJVoicePlayer


- (UIView *)p_voicePlayer{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupSubView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self p_setupSubView];
    }
    return self;
}

- (void)p_setupSubView{
    UIView *view = [self p_voicePlayer];
    view.frame = self.bounds;
    [self addSubview:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAct:)];
    [_voiceBg addGestureRecognizer:tap];
    
    [self p_setupVoiceIcon];
}

- (void)p_setupVoiceIcon{
    _voiceIcon.animationImages = [self p_voiceIconResource];
    _voiceIcon.animationDuration = .7;
    _voiceIcon.animationRepeatCount = MAXFLOAT;
}

- (void)startVoiceAnimating{
    if (!self.voiceIcon.isAnimating) {
        [self.voiceIcon startAnimating];
    }
}

- (void)stopVoiceAnimating{
    if (self.voiceIcon.isAnimating) {
        [self.voiceIcon stopAnimating];
    }
}

- (NSArray *)p_voiceIconResource{
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger IconsCount = 3;
    for (int i = 0; i < IconsCount; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"icon_voice_%d",i+1]]];
    }
    return arr;
}

- (void)tapGestureAct:(UITapGestureRecognizer *)sender {
    // 1. play voice
//    if (!self.voiceData) return;
    // 2. animation
    [self
     stopVoiceAnimating];
    [self startVoiceAnimating];
    
    if ([self.delegate respondsToSelector:@selector(voicePlayerStartPalyVoice:)]) {
        [self.delegate voicePlayerStartPalyVoice: self];
    }
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;
    _title.text = [NSString stringWithFormat:@"%.1f\"",duration];
}

//- (void)setVoiceData:(NSData *)voiceData{
//    _voiceData = voiceData;
//    self.hidden = NO;
//}

- (void)setShowDelBtn:(BOOL)showDelBtn{
    _delBtn.hidden = !showDelBtn;
}

- (IBAction)deleteBtnAct:(UIButton *)sender {
    self.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(voicePlayerDeleteBtnClicked:)]) {
        [self.delegate voicePlayerDeleteBtnClicked:self];
    }
}

#pragma mark -
#pragma mark - <AVAudioPlayerDelegate>
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self stopVoiceAnimating];
}


@end
