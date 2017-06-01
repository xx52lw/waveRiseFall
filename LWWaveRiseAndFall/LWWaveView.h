//
//  LWWaveView.h
//  LWWaveRiseAndFall
//
//  Created by 张星星 on 2017/5/6.
//  Copyright © 2017年 张星星. All rights reserved.
//

#import <UIKit/UIKit.h>
// ================================================================================================================================================================================================
#pragma mark 波浪视图
@interface LWWaveView : UIView

/** 波浪振幅（y = asin(wx+φ) + k） */
@property (nonatomic,assign) CGFloat    waveA;
/** 波浪周期T */
@property (nonatomic,assign) CGFloat    waveT;
/** 波浪的速率 */
@property (nonatomic,assign) CGFloat    waveS;
/** 两个波浪x偏移量 */
@property (nonatomic,assign) CGFloat    waveX;
/** 两个波浪y偏移量 */
@property (nonatomic,assign) CGFloat    waveY;

/** 创建视图 波浪的颜色数组 */
- (instancetype)initWithFrame:(CGRect)frame withWaveColors:(NSMutableArray<UIColor *> *)colorMutableArray;
/** 开始动起来 */
- (void)beginAnimation;
/** 停止动起来 */
- (void)stopAnimation;

@end
// ================================================================================================================================================================================================
