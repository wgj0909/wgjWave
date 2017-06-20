//
//  wgjWave.m
//  wgj-wave
//
//  Created by wangguanjun on 16/10/12.
//  Copyright © 2016年 wangguanjun. All rights reserved.
//

#import "wgjWave.h"

@interface wgjWave ()

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

@property (nonatomic, strong) UIImageView *iconImageView;


@end

@implementation wgjWave


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createTimeControl];
        
        [self addSubview:self.iconImageView];
        [self.layer addSublayer:self.realWaveLayer];
        [self.layer addSublayer:self.maskWaveLayer];

        
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        UIImage *image = [UIImage imageNamed:@"wgjIcon"];
        self.iconImageView = [[UIImageView alloc] initWithImage:image];
        
    }
    return _iconImageView;
}

- (CAShapeLayer *)realWaveLayer
{
    if (!_realWaveLayer) {
        self.realWaveLayer = [CAShapeLayer layer];

        _realWaveLayer.fillColor = self.realWaveColor.CGColor;
        
        
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer
{
    if (!_maskWaveLayer) {
        self.maskWaveLayer = [CAShapeLayer layer];

        _maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
        
        
    }
    return _maskWaveLayer;
}

- (void)setWaveHeight:(CGFloat)waveHeight
{
    _waveHeight = waveHeight;
    
    self.realWaveLayer.frame = CGRectMake(0, self.bounds.size.height - _waveHeight, self.bounds.size.width, _waveHeight);

    self.maskWaveLayer.frame = CGRectMake(0, self.bounds.size.height - _waveHeight, self.bounds.size.width, _waveHeight);
    
}

- (void)createTimeControl
{
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)wave
{
    self.offset += self.waveSpeed;
    CGFloat waveWidth = CGRectGetWidth(self.frame);
    CGFloat waveHeight = CGRectGetHeight(self.realWaveLayer.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    CGFloat iconHeight = CGRectGetHeight(self.iconImageView.frame);
    
    //真实浪
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, waveHeight);
    CGFloat y = 0.f;
    for (CGFloat x = 0.f; x <= waveWidth; x++) {
        y = waveHeight * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
    }

    CGPathAddLineToPoint(path, NULL, waveWidth, waveHeight);
    CGPathAddLineToPoint(path, NULL, 0, waveHeight);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    
    //遮罩浪
    CGMutablePathRef maskPath = CGPathCreateMutable();
    CGPathMoveToPoint(maskPath, NULL, 0, waveHeight);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= waveWidth; x++) {
        maskY = waveHeight * cosf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(maskPath, NULL, x, maskY);
    }
    
    CGPathAddLineToPoint(maskPath, NULL, waveWidth, waveHeight);
    CGPathAddLineToPoint(maskPath, NULL, 0, waveHeight);
    self.maskWaveLayer.path = maskPath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    
    
    CGFloat centX = self.bounds.size.width * 0.5;
    CGFloat centY = waveHeight *cosf(0.01 * self.waveCurvature *centX + self.offset * 0.045);
    CGRect iconFrame = self.iconImageView.frame;
    iconFrame.origin.y = selfHeight - iconHeight - waveHeight + centY;
    iconFrame.origin.x = centX - iconFrame.size.width * 0.5;
    self.iconImageView.frame = iconFrame;
    
}

@end
