//
//  LWWaveView.m
//  LWWaveRiseAndFall
//
//  Created by 张星星 on 2017/5/6.
//  Copyright © 2017年 张星星. All rights reserved.
//

#import "LWWaveView.h"
// ================================================================================================================================================================================================
#pragma mark 波浪视图
@interface LWWaveView ()

@property (nonatomic,strong) NSMutableArray<UIColor *> *colorMutableArray; // 需要画出的颜色数组
@property (nonatomic,strong) UIBezierPath    * bezizerPath; // 波浪曲线
@property (nonatomic,strong) NSTimer         * timer;       // 定时器
@property (nonatomic,assign) CGFloat           offsety;     // 波峰所在位置的y坐标
@property (nonatomic,assign) CGFloat           offsetx;     // 偏移x
@property (nonatomic,strong) CADisplayLink   * displayLink; // 定时器

@end
// ================================================================================================================================================================================================
#pragma mark 波浪视图tools
@interface LWWaveView (tools)

- (void)drawWaveColor:(UIColor *)color offsetX:(CGFloat)offsetx offsetY:(CGFloat)offsetY; // 绘制单层波浪
- (void)beginWave;      // 开始冲浪
- (void)addDisplayLink; // 添加定时器
- (void)remveDisplayLink;// 移除定时器

@end
// ================================================================================================================================================================================================
#pragma mark 波浪视图
@implementation LWWaveView

#pragma mark 创建视图 波浪的颜色
- (instancetype)initWithFrame:(CGRect)frame withWaveColors:(NSMutableArray<UIColor *> *)colorMutableArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.colorMutableArray  = colorMutableArray;
        self.waveA = 10.0f;
        self.waveT = 1.5 * (M_PI * 2) / frame.size.width;
        self.waveS = 0.5;
        self.waveX = 70;
        self.waveY = 5;
    }
    return self;
}

#pragma mark 开始动起来
- (void)beginAnimation {
    [self addDisplayLink];
}
#pragma mark 停止动起来
- (void)stopAnimation {
    [self remveDisplayLink];
}
#pragma mark 重写drawRect
- (void)drawRect:(CGRect)rect {
   // 绘制波浪
    [self.colorMutableArray enumerateObjectsUsingBlock:^(UIColor * color, NSUInteger idx, BOOL * _Nonnull stop) {
        [self drawWaveColor:color offsetX:self.waveX * (idx + 1) offsetY:self.waveY * (idx + 1)];
    }];
}



@end
// ================================================================================================================================================================================================
#pragma mark 波浪视图tools
@implementation LWWaveView (tools)

#pragma mark 绘制单层波浪
- (void)drawWaveColor:(UIColor *)color offsetX:(CGFloat)offsetx offsetY:(CGFloat)offsety {
   // 波浪动画的高度
    CGFloat end_offY = self.frame.size.height / 2 + self.waveA;
    if (self.offsety != end_offY) {
        if (end_offY < self.offsety) {
            self.offsety = self.offsety - (self.offsety - end_offY);
            self.offsety = MAX(end_offY, self.offsety);
        }
        else {
            self.offsety = self.offsety + (end_offY - self.offsety);
            self.offsety = MIN(end_offY, self.offsety);
        }
    }
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    for (CGFloat nextX = 0.0; nextX < self.frame.size.width; nextX++) {
        // 正弦函数，绘制波浪 y = asin(wx+φ) + k
        CGFloat nextY = self.waveA * sin(self.waveT * nextX + self.offsetx + offsetx / self.bounds.size.width * 2 * M_PI) + (self.offsety + offsety);
        NSLog(@"x = %lf,y = %lf",nextX,nextY);
        CGPoint point = CGPointMake(nextX, nextY);
        if (nextX == 0) {
            [wavePath moveToPoint:point];
        }
        else {
            [wavePath addLineToPoint:point];
        }
        
    }
    [wavePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [color set];
    [wavePath fill];
}
#pragma mark 开始冲浪
- (void)beginWave {
    self.offsetx += self.waveS;
    if (self.offsetx >= self.frame.size.width * 20) {
        self.offsetx = 0;
    }
    [self setNeedsDisplay];
}
#pragma mark 添加定时器
- (void)addDisplayLink {
    [self remveDisplayLink];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(beginWave)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
#pragma mark 移除定时器
- (void)remveDisplayLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
}
@end
// ================================================================================================================================================================================================
