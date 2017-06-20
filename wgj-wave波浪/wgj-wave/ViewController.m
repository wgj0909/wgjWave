//
//  ViewController.m
//  wgj-wave
//
//  Created by wangguanjun on 16/10/12.
//  Copyright © 2016年 wangguanjun. All rights reserved.
//

#import "ViewController.h"
#import "wgjWave.h"

@interface ViewController ()

@property (nonatomic, strong) wgjWave *waveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.waveView];
}

- (UIView *)waveView
{
    if (!_waveView) {
        self.waveView = [[wgjWave alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        _waveView.backgroundColor = [UIColor orangeColor];
    
        _waveView.waveCurvature = 0.8;
        _waveView.waveSpeed = 0.6;
        _waveView.waveHeight = 6;
        _waveView.realWaveColor = [UIColor colorWithRed:0.7 green:0.9 blue:0.9 alpha:1];
        _waveView.maskWaveColor = [UIColor whiteColor];
        
        
    }
    return  _waveView;
}

@end
