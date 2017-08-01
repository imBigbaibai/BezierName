//
//  BezireLine.m
//  贝塞尔曲线
//
//  Created by admin on 2017/7/31.
//  Copyright © 2017年 xuwenbo. All rights reserved.
//

#import "BezireLine.h"

#pragma mark - 二次贝塞尔曲线
// 计算贝塞尔曲线两个点之间的中心点，使曲线变的更加圆滑，曲线不会再出现棱角
static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}
@interface BezireLine  (){
    
    UIBezierPath *path;
    CGPoint previousPoint;

}

@end

@implementation BezireLine

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        
        self.layer.cornerRadius = 50;
        
        self.layer.masksToBounds = YES;
        
        // 再自定义该类（UIView子类）的初始化操作。
        [self commonInit];
        
    }
    return self;
}
#pragma mark - 初始手势和路径path
- (void)commonInit {
    
    path = [UIBezierPath bezierPath];
    
    //添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [pan velocityInView:self];
    
    //设置最多只能识别一个手指
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    
    [self addGestureRecognizer:pan];
    
    // 长按清除
//    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(erase)]];
    
}
#pragma mark - 手势回调事件
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //设置 手势定位的位置
    CGPoint currentPoint = [pan locationInView:self];
    
    //取中间点
    CGPoint midPoint = midpoint(previousPoint, currentPoint);

    //设置起点，并将点都加到路径里，然后调绘制，画线
    if (pan.state == UIGestureRecognizerStateBegan) {
        [path moveToPoint:currentPoint];
    } else if (pan.state == UIGestureRecognizerStateChanged){
//        [path addLineToPoint:currentPoint];
        //二次贝塞尔曲线
        [path addQuadCurveToPoint:midPoint controlPoint:previousPoint];

    }
    
    
    previousPoint = currentPoint;
    //每次都会调drawRect
    [self setNeedsDisplay];
}

- (void)erase {
    path = [UIBezierPath bezierPath];
    [self setNeedsDisplay];
}

#pragma mark - 重写 UIView 的绘制方法
- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor whiteColor];
    [color set]; //设置线条颜色
    
//    path.lineWidth = 5.0;
//    path.lineCapStyle = kCGLineCapRound; //线条拐角
//    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path stroke];
}

- (void)clearBezireLine
{
    [self setNeedsDisplay];
}

@end
