//
//  SFJRcordView.h
//  AccountBook
//
//  Created by ZhaoWei on 16/12/5.
//  Copyright © 2016年 ZhaoWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFJRcordAnimationView : UIView

/**
 根据录音声音高低更新录音蒙版动画

 @param lowPassResults 声音高低值
 */
- (void)updateRecordAnimationByLowPassResults:(double)lowPassResults;

/**
  更新label为手指划出的状态
 */
- (void)updateLabelForTouchUpOutSide;

/**
 更新label为手指移回来的状态
 */
- (void)upDateLabelForTouchUpInside;

@end
