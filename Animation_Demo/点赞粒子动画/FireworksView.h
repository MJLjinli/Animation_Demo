//
//  FireworksView.h
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/28.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FireworksView : UIView

@property(nonatomic,strong)UIImage *particleImage;  //粒子图片
@property(nonatomic,assign)CGFloat particleScale;   //粒子规模
@property(nonatomic,assign)CGFloat particleScaleRange;  //粒子范围



- (void)animate;

@end
