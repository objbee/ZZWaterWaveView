//
//  ZZWaterWaveView.m
//  ZZWaterWaveView
//
//  Created by yuanye on 2016/11/14.
//  Copyright © 2016年 yuanye. All rights reserved.
// y = Asin(ωx+φ)+C

#import "ZZWaterWaveView.h"

@interface ZZWaterWaveView ()

@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
//
@property (nonatomic, assign) CGFloat waveAmplitude; // 振幅 A, 波浪高度
@property (nonatomic, assign) CGFloat waveCycle;     // 周期 ω, 波浪数量
@property (nonatomic, assign) CGFloat waveOffsetX;   // 横向偏移 φ, 波浪流动
@property (nonatomic, assign) CGFloat waveDefaultY;  // 纵向位置 C, 波浪竖直位置
@property (nonatomic, assign) CGFloat waveWidth;     // 波浪宽度

@end

@implementation ZZWaterWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        
        // default
        self.fillColor = [self colorWithValue:0x4991fd];
        self.waveAmplitude = 5.0;
        self.waveCycle = 1/40.0;
        self.waveOffsetX = 0.0;
        self.waveDefaultY = self.frame.size.height/2.0;
        self.waveWidth = self.frame.size.width;
        self.waveSpeed = 0.2;
        
        [self.layer addSublayer:self.waveLayer];
    }
    return self;
}

#pragma mark - action

- (void)updateCurrentWave
{
    self.waveOffsetX += self.waveSpeed;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, nil, 0, self.waveDefaultY);
    CGFloat y = 0.0;
    for (CGFloat x = 0.0; x <= self.waveWidth; x ++) {
        // 正弦波浪公式
        y = self.waveAmplitude * sin(self.waveCycle * x + self.waveOffsetX) + self.waveDefaultY;
        // y = self.waveAmplitude * sinf((360/self.waveWidth)*(x*M_PI/180) - self.waveOffsetX*M_PI/180) + self.waveDefaultY;
        CGPathAddLineToPoint(pathRef, nil, x, y);
    }
    CGPathAddLineToPoint(pathRef, nil, self.waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(pathRef, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(pathRef);
    self.waveLayer.path = pathRef;
    CGPathRelease(pathRef);
}

#pragma mark - public method

- (void)startWave
{
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWave
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark - private method

- (UIColor *)colorWithValue:(NSUInteger)rgbValue
{
    return [self colorWithValue:rgbValue alpha:1.0];
}

- (UIColor *)colorWithValue:(NSUInteger)rgbValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

#pragma mark - getter and setter

- (CAShapeLayer *)waveLayer
{
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = self.fillColor.CGColor;
    }
    return _waveLayer;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateCurrentWave)];
    }
    return _displayLink;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    self.waveLayer.fillColor = fillColor.CGColor;
}

- (void)setWaveSpeed:(CGFloat)waveSpeed
{
    _waveSpeed = waveSpeed;
}

@end
