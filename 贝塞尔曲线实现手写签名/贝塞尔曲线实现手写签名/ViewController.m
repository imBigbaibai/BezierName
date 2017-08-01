//
//  ViewController.m
//  贝塞尔曲线实现手写签名
//
//  Created by admin on 2017/7/31.
//  Copyright © 2017年 xuwenbo. All rights reserved.
//

#import "ViewController.h"
#import "BezireLine.h"

@interface ViewController ()
{
    BezireLine *line;
    
    UIImageView *imageView;
}
@end

@implementation ViewController

#warning 视图和按钮的坐标，按自己的需要自行设置

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView = [[UIImageView alloc] init];
    
    imageView.frame = CGRectMake(10, 440, 300, 100);
    
    imageView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:imageView];
    
    [self setButtonView];
    
    [self setLine];
}

//设置曲线图
- (void)setLine
{
    line = [[BezireLine alloc] init];
    
    line.frame = CGRectMake(10, 48, self.view.frame.size.width-20,300);
    
    [self.view addSubview:line];
}

//设置按钮
- (void)setButtonView
{
    for (int i = 0; i<2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.masksToBounds = YES;
        
        button.layer.cornerRadius = 15;
        
        button.tag = 100+i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(10 + 100*i, 400, 60+40*i, 30);
        
        button.backgroundColor = [UIColor orangeColor];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        switch (i) {
            case 0:
                [button setTitle:@"确定" forState:UIControlStateNormal];
                break;
            case 1:
                [button setTitle:@"取消(删除)" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
        [self.view addSubview:button];
        
    }

}

- (void)buttonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
            [self imageFromView:line];
            
            break;
        case 101:
            //清除 path 线条
            [line removeFromSuperview];
            [self setLine];
            break;
        default:
            break;
    }
}

//获取屏幕上对应的View，并截取为图片
- (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image = theImage;
    
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
