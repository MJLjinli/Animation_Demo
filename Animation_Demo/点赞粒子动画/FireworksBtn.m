//
//  FireworksBtn.m
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/31.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "FireworksBtn.h"
#import "FireworksView.h"
@interface FireworksBtn()

@property(nonatomic,strong)FireworksView *fireView;

@end



@implementation FireworksBtn


- (void)setup
{
    self.clipsToBounds = NO;
    _fireView = [[FireworksView alloc]init];
    [self insertSubview:_fireView atIndex:0];;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.fireView.frame = self.bounds;
    [self insertSubview:self.fireView atIndex:0];
    
}



- (void)animate
{
    [self.fireView animate];
}


- (void)popInsideWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) wealSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/3.0 animations:^{
            typeof(self) stongSelf = wealSelf;
            stongSelf.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
            typeof(self) stongSelf = wealSelf;
            stongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations:^{
            typeof(self) stongSelf = wealSelf;
            stongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)popOutsideWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) wealSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            typeof(self) stongSelf = wealSelf;
            stongSelf.transform = CGAffineTransformMakeScale(0.8,0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            typeof(self) stongSelf = wealSelf;
            stongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
        
        
    } completion:^(BOOL finished) {
        
    }];
}

- (UIImage *)particleImage
{
    return self.fireView.particleImage;
}


- (void)setParticleImage:(UIImage *)particleImage
{
    self.fireView.particleImage = particleImage;
}

- (CGFloat)particleScale
{
    return self.fireView.particleScale;
}

- (void)setParticleScale:(CGFloat)particleScale
{
    self.fireView.particleScale = particleScale;
}

- (CGFloat)particleScaleRange
{
    return self.fireView.particleScaleRange;
}

- (void)setParticleScaleRange:(CGFloat)particleScaleRange
{
    self.fireView.particleScaleRange = particleScaleRange;
}




@end
