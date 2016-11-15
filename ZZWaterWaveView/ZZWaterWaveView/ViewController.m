//
//  ViewController.m
//  ZZWaterWaveView
//
//  Created by yuanye on 2016/11/14.
//  Copyright © 2016年 yuanye. All rights reserved.
//

#import "ViewController.h"
#import "ZZWaterWaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZZWaterWaveView *waveView = [[ZZWaterWaveView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    [self.view addSubview:waveView];
    [waveView startWave];
}

@end
