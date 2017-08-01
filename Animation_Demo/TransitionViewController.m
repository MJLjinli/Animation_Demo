//
//  TransitionViewController.m
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/27.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "TransitionViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface TransitionViewController ()
@property(nonatomic,strong)UIView *demoView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _demoView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_WIDTH/2-50, 100, 100)];
    _demoView.backgroundColor = [UIColor grayColor];
    _demoView.alpha = 1.0;
    [self.view addSubview:_demoView];
    
    
    
}
- (IBAction)btnAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            [self fadeAnimation];
            break;
   
        }
        case 1:
        {
            [self MoveInAnimation];
            break;
        }
        case 2:
        {
            [self PushAnimation];
            break;
        }
        case 3:
        {
            [self RevealAnimation];
            break;
        }
        case 4:
        {
            [self cubeAnimation];
            break;
        }
        default:
            break;
    }
    
    
}


/**
 渐变消失
 */
- (void)fadeAnimation
{
    _demoView.backgroundColor = [UIColor redColor];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade; //动画类型
    anima.subtype = kCATransitionFromRight; //动画的终点
    anima.autoreverses = YES;
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
    
}

/**
 进入覆盖
 */
- (void)MoveInAnimation
{
    _demoView.backgroundColor = [UIColor redColor];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn; //动画类型
    anima.subtype = kCATransitionFromRight; //动画的终点
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"moveInAnimation"];
}


/**
 推出
 */
- (void)PushAnimation
{
    _demoView.backgroundColor = [UIColor redColor];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush; //动画类型
    anima.subtype = kCATransitionFromRight; //动画的终点
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"pushAnimation"];
}

/**
 揭开
 */
- (void)RevealAnimation
{
    _demoView.backgroundColor = [UIColor redColor];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal; //动画类型
    anima.subtype = kCATransitionFromRight; //动画的终点
    anima.duration = 1.0f;
    anima.autoreverses = YES;

    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}


/**
 立体翻滚
 */
- (void)cubeAnimation
{
    //吸走:suckEffect
    //翻滚:oglFlip
    //涟漪效果:rippleEffect
    //翻页出去:pageCurl
    //翻页进来:pageUnCurl
    //相机开:cameraIrisHollowOpen
    //相机关:cameraIrisHollowClose
    _demoView.backgroundColor = [UIColor redColor];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube"; //动画类型
    anima.subtype = kCATransitionFromRight; //动画的终点
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cubeAnimation"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
