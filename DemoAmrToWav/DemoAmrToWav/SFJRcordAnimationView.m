//
//  SFJRcordView.m
//  AccountBook
//
//  Created by ZhaoWei on 16/12/5.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//

#import "SFJRcordAnimationView.h"
@interface SFJRcordAnimationView ()

/** title */
@property (nonatomic, strong) UILabel *label;

/** imageView */
@property (nonatomic, strong) UIImageView *recordImageView;
@end
@implementation SFJRcordAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5 ];
    self.layer.cornerRadius = 8;
    
    [self addSubview:self.label];
    [self addSubview:self.recordImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    
    CGFloat lblW = self.label.frame.size.width;
    CGFloat lblH = self.label.frame.size.height;
    
    CGFloat labelY = selfH - lblH;
    CGFloat labelX = (selfW - lblW) / 2;
    self.label.frame = CGRectMake(labelX, labelY, lblW, lblH);
    
    CGFloat imageW = selfW * .5;
    CGFloat imageH = selfH * .5;
    CGFloat imageX = (selfW - imageW) * .5;
    CGFloat imageY = (selfH - imageH) * .5;
    self.recordImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
}


- (void)updateLabelForTouchUpOutSide{
    _label.text = @" 松开手指,取消录音 ";
    [_label sizeToFit];
    _label.backgroundColor = [UIColor redColor];
    _label.layer.cornerRadius = _label.frame.size.height * .5;
    _label.layer.masksToBounds = YES;
}

- (void)upDateLabelForTouchUpInside{
    _label.text = @" 向上滑动,取消录音 ";
    _label.backgroundColor = [UIColor clearColor];
}

/**  */
- (UILabel *)label{
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @" 向上滑动,取消录音 ";
        _label.textColor = [UIColor whiteColor];
        [_label sizeToFit];
    }
    return _label;
}

/** 录音检测 */
- (UIImageView *)recordImageView{
    
    if (!_recordImageView) {
        _recordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"语音-0"]];
    }
    return _recordImageView;
}

- (void)updateRecordAnimationByLowPassResults:(double)lowPassResults{
    [self updateRecorodImage:self.recordImageView lowPassResults:lowPassResults];
}

- (void)updateRecorodImage:(UIImageView *)recordImage lowPassResults:(double)lowPassResults{
    if (0<lowPassResults<=0.06) {
        [recordImage setImage:[UIImage imageNamed:@"语音-0.png"]];
    }else if (0.06<lowPassResults<=0.13) {
        [recordImage setImage:[UIImage imageNamed:@"语音-1.png"]];
    }else if (0.13<lowPassResults<=0.20) {
        [recordImage setImage:[UIImage imageNamed:@"语音-2.png"]];
    }else if (0.20<lowPassResults<=0.27) {
        [recordImage setImage:[UIImage imageNamed:@"语音-3.png"]];
    }else if (0.27<lowPassResults<=0.34) {
        [recordImage setImage:[UIImage imageNamed:@"语音-3.png"]];
    }else if (0.34<lowPassResults<=0.41) {
        [recordImage setImage:[UIImage imageNamed:@"语音-4.png"]];
    }else if (0.41<lowPassResults<=0.48) {
        [recordImage setImage:[UIImage imageNamed:@"语音-5.png"]];
    }else if (0.48<lowPassResults<=0.55) {
        [recordImage setImage:[UIImage imageNamed:@"语音-5.png"]];
    }else if (0.55<lowPassResults<=0.62) {
        [recordImage setImage:[UIImage imageNamed:@"语音-6.png"]];
    }else if (0.62<lowPassResults<=0.69) {
        [recordImage setImage:[UIImage imageNamed:@"语音-6.png"]];
    }else if (0.69<lowPassResults<=0.76) {
        [recordImage setImage:[UIImage imageNamed:@"语音-7.png"]];
    }else if (0.76<lowPassResults<=0.83) {
        [recordImage setImage:[UIImage imageNamed:@"语音-7.png"]];
    }else if (0.83<lowPassResults<=0.9) {
        [recordImage setImage:[UIImage imageNamed:@"语音-8.png"]];
    }else {
        [recordImage setImage:[UIImage imageNamed:@"语音-9.png"]];
    }
}





@end
