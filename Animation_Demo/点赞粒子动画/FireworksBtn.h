//
//  FireworksBtn.h
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/31.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FireworksBtn : UIButton

@property(nonatomic,strong)UIImage *particleImage;
@property (assign, nonatomic) CGFloat particleScale;
@property (assign, nonatomic) CGFloat particleScaleRange;


- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;
@end
