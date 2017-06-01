//
//  ViewController.m
//  LWWaveRiseAndFall
//
//  Created by 张星星 on 2017/5/6.
//  Copyright © 2017年 张星星. All rights reserved.
//

#import "ViewController.h"
#import "LWWaveView.h"
// ================================================================================================================================================================================================
@interface ViewController ()

@property (nonatomic,strong) LWWaveView    *  waveView; // 波浪视图

@end
// ================================================================================================================================================================================================
@implementation ViewController

- (LWWaveView *)waveView {
    if (_waveView == nil) {
        _waveView = [[LWWaveView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) withWaveColors:[NSMutableArray arrayWithObjects:[UIColor colorWithRed:0.9 green:0.8 blue:0.9 alpha:0.4],[UIColor colorWithRed:0.9 green:0.8 blue:0.9 alpha:0.4], nil]];
        _waveView.backgroundColor = [UIColor clearColor];
    }
    return _waveView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.waveView];
    [self.waveView beginAnimation];
}

@end
// ================================================================================================================================================================================================
