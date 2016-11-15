//
//  ZZWaterWaveView.h
//  ZZWaterWaveView
//
//  Created by yuanye on 2016/11/14.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZWaterWaveView : UIView

@property (nonatomic, strong) UIColor *fillColor;    // 波浪颜色
@property (nonatomic, assign) CGFloat waveSpeed;     // 波浪速度

- (void)startWave;
- (void)stopWave;

@end
