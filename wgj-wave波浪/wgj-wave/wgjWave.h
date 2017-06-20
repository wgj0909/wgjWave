//
//  wgjWave.h
//  wgj-wave
//
//  Created by wangguanjun on 16/10/12.
//  Copyright © 2016年 wangguanjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wgjWave : UIView


@property (nonatomic, assign) CGFloat waveCurvature;//曲度
@property (nonatomic, assign) CGFloat waveSpeed; //浪速
@property (nonatomic, assign) CGFloat waveHeight; //浪高
@property (nonatomic, strong) UIColor *realWaveColor; //实浪颜色
@property (nonatomic, strong) UIColor *maskWaveColor; //遮罩浪颜色



@end
