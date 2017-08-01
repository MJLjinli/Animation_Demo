//
//  ViewController.m
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/27.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "ViewController.h"
#import "TransitionViewController.h"
#import "CaseViewController.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface ViewController ()

@property(nonatomic,strong)UIView *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _demoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_WIDTH/2-50, 100, 100)];
    _demoView.backgroundColor = [UIColor grayColor];
    _demoView.alpha = 1.0;
    [self.view addSubview:_demoView];
   
}



- (IBAction)ClickAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            [self displacementAnimation];
            
            break;
        }
        case 1:
        {
            [self opacityAnimation];
            break;
        }
        case 2:
        {
            [self transformScaleAnimation];
            break;
        }
        case 3:
        {
            [self rotaAnimation];
            break;
        }
        case 4:
        {
            [self backgroundAnimation];
            break;
        }
        case 100: //动画案例
        {
            CaseViewController *caseVC = [[CaseViewController alloc]init];
            [self.navigationController pushViewController:caseVC animated:YES];
            break;
        }
        case 101: //过渡动画
        {
            TransitionViewController *transitionVC = [[TransitionViewController alloc ]init];
            [self.navigationController pushViewController:transitionVC animated:YES];
            break;
        }
        default:
            break;
    }
    
    
}



/**
 位移:KeyPath:position
 */
- (void)displacementAnimation
{
    _demoView.frame = CGRectMake(15, SCREEN_WIDTH/2-50, 100, 100);
    //1.代码块
//    [UIView animateWithDuration:1.0 animations:^{
//        _demoView.frame = CGRectMake(SCREEN_WIDTH - 15 - 100, SCREEN_WIDTH/2-50, 100, 100);
//    } completion:^(BOOL finished) {
//        _demoView.frame = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_WIDTH/2-50, 100, 100);
//    }];
    //2.[begin,commit]模式
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationRepeatAutoreverses:YES];//按照原动画返回执行
//    [UIView setAnimationRepeatCount:2];//动画重复的次数
//    _demoView.frame = CGRectMake(SCREEN_WIDTH - 15 - 100, SCREEN_WIDTH/2-50, 100, 100);
//    [UIView commitAnimations];
    //3.CoreAnimation中的类
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(15,  SCREEN_WIDTH/2)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH - 15 - 100,  SCREEN_WIDTH/2)];
    animation.duration = 1.0f;
    //kCAMediaTimingFunctionEaseIn ---先快后慢
    //kCAMediaTimingFunctionLinear ---线性
    //kCAMediaTimingFunctionEaseOut ---先慢后快
    //kCAMediaTimingFunctionEaseInEaseOut ---先慢后快再慢
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_demoView.layer addAnimation:animation forKey:@"positionAnimation"];
    

}


/**
 透明度
 */
- (void)opacityAnimation
{
//    [UIView animateWithDuration:1.0 animations:^{
//        _demoView.alpha = 0.3;
//    } completion:^(BOOL finished) {
//        _demoView.alpha = 1.0;
//    }];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"opacityAnimation"];
}


/**
 缩放
 */
- (void)transformScaleAnimation
{
    //transform.scale --宽,高比例
    //transform.scale.x ---宽的比例
    //transform.scale.y ---高的比例变换
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
}


/**
 旋转
 */
- (void)rotaAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.toValue = [NSNumber numberWithFloat:-M_PI];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"rotationAnimation"];
}

- (void)backgroundAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue = (id)[UIColor redColor].CGColor;
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"backgroundColorAnimation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
