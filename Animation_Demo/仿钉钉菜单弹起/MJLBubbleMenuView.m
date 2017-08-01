//
//  MJLBubbleMenuView.m
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/31.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "MJLBubbleMenuView.h"

#define KDefaultDuration 0.25f

@interface MJLBubbleMenuView ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic,strong)NSMutableArray *buttonContainer;
@property(nonatomic,assign)CGRect originFrame;

@end



@implementation MJLBubbleMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame expansionDirection:(ExDirection)exDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.exDirection = exDirection;
    }
    return self;
}

//添加菜单
- (void)addButtons:(NSArray *)buttons
{
    assert(buttons != nil);
    for (UIButton *button in buttons) {
        [self addButton:button];
    }
    if (self.homeButtonView != nil) {
        [self bringSubviewToFront:self.homeButtonView];
    }
}


- (void)addButton:(UIButton *)button
{
    assert(button != nil);
    if (_buttonContainer == nil) {
        _buttonContainer = [[NSMutableArray alloc]init];
    }
    if (![_buttonContainer containsObject:button]) {
        [_buttonContainer addObject:button];
        [self addSubview:button];
        button.hidden = YES;
    }
}



/**
 显示菜单
 */
- (void)showButtons
{
    //菜单将要展开的代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(bubbleMenuViewWillExpland:)]) {
        [self.delegate bubbleMenuViewWillExpland:self];
    }
    //展开的frame
    [self setFrameAfterExpansion];
    self.userInteractionEnabled = NO;
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    [CATransaction setCompletionBlock:^{
        for (UIButton *button in _buttonContainer) {
            button.transform = CGAffineTransformIdentity;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(bubbleMenuViewDidExpland:)]) {
            [self.delegate bubbleMenuViewDidExpland:self];
        }
        self.userInteractionEnabled = YES;
    }];
    
    NSArray *buttonContainer = _buttonContainer;
    if (self.exDirection == ExDirectionUp || self.exDirection == ExDirectionLeft) {
        buttonContainer = [self reversedOrderButtonContainer:_buttonContainer];
    }
    for (int i = 0; i < buttonContainer.count; i++) {
        int index = (int)buttonContainer.count - (i+1);
        UIButton *button = [buttonContainer objectAtIndex:index];
        button.hidden = NO;
        //位移动画
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        CGPoint originPosition = CGPointZero;
        CGPoint finalPosition = CGPointZero;
        switch (self.exDirection) {
            case ExDirectionUp:
            {
                originPosition = CGPointMake(self.frame.size.width/2, self.frame.size.height-self.homeButtonView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width/2, self.frame.size.height - self.homeButtonView.frame.size.height - button.frame.size.height/2-self.buttonSpacing - ((button.frame.size.height+self.buttonSpacing)*index));
                
                break;
            }
            case ExDirectionDown:
            {
                originPosition = CGPointMake(self.frame.size.width/2, self.homeButtonView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width/2, self.homeButtonView.frame.size.height + button.frame.size.height/2+self.buttonSpacing + (button.frame.size.height + self.buttonSpacing)*index);
                break;
            }
            case ExDirectionLeft:
            {
                originPosition = CGPointMake(self.frame.size.width - _homeButtonView.frame.size.width, self.frame.size.height/2.f);
                finalPosition = CGPointMake(self.frame.size.width - self.homeButtonView.frame.size.width - button.frame.size.width/2.f - self.buttonSpacing
                                            - ((button.frame.size.width + self.buttonSpacing) * index),
                                            self.frame.size.height/2.f);

                break;
            }
            case ExDirectionRight:
            {
                originPosition = CGPointMake(self.homeButtonView.frame.size.width, self.frame.size.height/2.f);
                finalPosition = CGPointMake(self.homeButtonView.frame.size.width + button.frame.size.width/2+self.buttonSpacing + (button.frame.size.width + self.buttonSpacing)*index, self.frame.size.height/2);
                break;
            }
            default:
                break;
        }
        
        positionAnimation.duration = self.animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        positionAnimation.beginTime = CACurrentMediaTime()+(self.animationDuration/(float)_buttonContainer.count*(float)i);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        [button.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        button.layer.position = finalPosition;
        
        //缩放动画
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = self.animationDuration;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        scaleAnimation.beginTime = CACurrentMediaTime() +(self.animationDuration/(float)_buttonContainer.count*(float)i)+0.03f;
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        button.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        
        
    }
    [CATransaction commit];
   
    _isDisappler = NO;
    [self layoutSubviews];
    
}

//倒序排列数组
- (NSArray *)reversedOrderButtonContainer:(NSArray *)array
{
    NSMutableArray *reverseArray = [NSMutableArray array];
    for (int i = (int)array.count - 1; i >= 0; i--) {
        [reverseArray addObject:[array objectAtIndex:i]];
    }
    
    return reverseArray;
}

/**
 隐藏菜单
 */
- (void)dismissButtons
{
    if ([self.delegate respondsToSelector:@selector(bubbleMenuViewWillDisapper:)]) {
        [self.delegate bubbleMenuViewWillDisapper:self];
    }
    
    self.userInteractionEnabled = NO;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationDuration];
    [CATransaction setCompletionBlock:^{
        self.frame = _originFrame;
        for (UIButton *button in _buttonContainer) {
            button.transform = CGAffineTransformIdentity;
            button.hidden = YES;
        }
        
        if (self.delegate != nil) {
            if ([self.delegate respondsToSelector:@selector(bubbleMenuViewDidDisapper:)]) {
                [self.delegate bubbleMenuViewDidDisapper:self];
            }
        }
        
        self.userInteractionEnabled = YES;
    }];
    
    int index = 0;
    for (int i = (int)_buttonContainer.count - 1; i >= 0; i--) {
        UIButton *button = [_buttonContainer objectAtIndex:i];
        
        if (self.exDirection == ExDirectionDown || self.exDirection == ExDirectionRight) {
            button = [_buttonContainer objectAtIndex:index];
        }
        
        // scale animation
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        scaleAnimation.duration = _animationDuration;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)index) + 0.03;
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        button.transform = CGAffineTransformMakeScale(1.f, 1.f);
        
        // position animation
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        
        CGPoint originPosition = button.layer.position;
        CGPoint finalPosition = CGPointZero;
        
        switch (self.exDirection) {
            case ExDirectionLeft:
                finalPosition = CGPointMake(self.frame.size.width - self.homeButtonView.frame.size.width, self.frame.size.height/2.f);
                break;
                
            case ExDirectionRight:
                finalPosition = CGPointMake(self.homeButtonView.frame.size.width, self.frame.size.height/2.f);
                break;
                
            case ExDirectionUp:
                finalPosition = CGPointMake(self.frame.size.width/2.f, self.frame.size.height - self.homeButtonView.frame.size.height);
                break;
                
            case ExDirectionDown:
                finalPosition = CGPointMake(self.frame.size.width/2.f, self.homeButtonView.frame.size.height);
                break;
                
            default:
                break;
        }
        
        positionAnimation.duration = _animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        positionAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_buttonContainer.count * (float)index);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [button.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        
        button.layer.position = originPosition;
        index++;
    }
    
    [CATransaction commit];
    
    _isDisappler = YES;
}

/**
 初始化
 */
- (void)setUp
{
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    self.animatedHighlighting = YES;
    self.disapplerAfterSelection = YES;
    self.animationDuration = KDefaultDuration;
    self.normalAlpha = 1.0f;
    self.highlightAlpha = 0.45f;
    self.originFrame = self.frame;
    self.buttonSpacing = 20.f;
    _isDisappler = YES;
    self.exDirection = ExDirectionUp;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    self.tapGestureRecognizer.cancelsTouchesInView = NO;
    self.tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.tapGestureRecognizer];
    
}


/**
 设置展开后self.frame
 */
- (void)setFrameAfterExpansion
{
    CGFloat buttonHeight = [self getCombinedButtonHeight];
    CGFloat buttonWidth = [self getCombinedButtonWidth];
    switch (self.exDirection) {
        case ExDirectionUp: //向上
        {
            self.homeButtonView .autoresizingMask = UIViewAutoresizingFlexibleTopMargin;    //自动调整与superview的顶部的距离,保证与superview的底部距离不变
            CGRect frame = self.frame;
            frame.origin.y -= buttonHeight;//y向上移动
            frame.size.height += buttonHeight;
            self.frame = frame;
            break;
        }
        case ExDirectionDown: //向下
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;  //保证与superview的顶部保持不变
            CGRect frame = self.frame;
            frame.size.height += buttonHeight;
            self.frame = frame;
            break;
        }
        case ExDirectionLeft:   //向左
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;   //保证与superview右边的距离不变
            CGRect frame = self.frame;
            frame.origin.x -= buttonWidth;
            frame.size.width += buttonWidth;
            self.frame = frame;
            break;
        }
        case ExDirectionRight:  //向右
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;   //保证与superview左边的距离不变
            CGRect frame = self.frame;
            frame.size.width += buttonWidth;
            self.frame = frame;
            break;
        }
        default:
            break;
    }
}


//获取总共button的高度
- (CGFloat)getCombinedButtonHeight
{
    CGFloat height = 0;
    for (UIButton *button in _buttonContainer) {
        height += button.frame.size.height + self.buttonSpacing;
    }
    return height;
}
//获取总共button的宽度
- (CGFloat)getCombinedButtonWidth
{
    CGFloat width = 0;
    for (UIButton *button in _buttonContainer) {
        width += button.frame.size.width + self.buttonSpacing;
    }
    return width;
}


#pragma mark - 手势
- (void)tapGestureRecognizerAction:(id)sender
{
    if (self.tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [self.tapGestureRecognizer locationOfTouch:0 inView:self];
        
        if (_disapplerAfterSelection && _isDisappler == NO && CGRectContainsPoint(self.homeButtonView.frame, touchLocation) == false) {
            [self dismissButtons];
        }
    }
}

#pragma mark - 主页按钮的高亮
- (void)setTouchHeighlighted:(BOOL)highlighted
{
    float alphaValue = highlighted ? _highlightAlpha : _normalAlpha;
    
    if (self.homeButtonView.alpha == alphaValue)
        return;
    
    if (_animatedHighlighting) {
        
        [self _animateWithBlock:^{
            if (self.homeButtonView != nil) {
                self.homeButtonView.alpha = alphaValue;
            }
        }];
    } else {
        if (self.homeButtonView != nil) {
            self.homeButtonView.alpha = alphaValue;
        }
    }
}

- (void)_animateWithBlock:(void (^)(void))animationBlock {
    //过渡转换的动画
    [UIView transitionWithView:self
                      duration:KDefaultDuration
                       options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                    animations:animationBlock
                    completion:NULL];
}
#pragma mark -根据点获取到子视图
- (UIView *)subviewForPoint:(CGPoint)point
{
    for (UIView *subview in self.subviews) {
        if (CGRectContainsPoint(subview.frame, point)) {
            return subview;
        }
    }
    
    return self;
}

#pragma mark -touchesMethod

//手指按下
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    if (CGRectContainsPoint(self.homeButtonView.frame, [touch locationInView:self])) {
        [self setTouchHeighlighted:YES];
    }
}
//手指抬起
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    [self setTouchHeighlighted:NO];
    
    if (CGRectContainsPoint(self.homeButtonView.frame, [touch locationInView:self])) {
        if (_isDisappler) {
            [self showButtons];
        } else {
            [self dismissButtons];
        }
    }
}
//某个系统事件(例如电话呼入)打断触摸过程
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setTouchHeighlighted:NO];
}

//手指在屏幕上的移动(随着手指的移动会调用该方法)
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    //CGRectContainsPoint:判断给定的点,是否被CGRect包含
    [self setTouchHeighlighted:CGRectContainsPoint(self.homeButtonView.frame, [touch locationInView:self])];
}


//用来寻找哪个视图被触摸了
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];

    if (hitView == self) {
        if (_isDisappler) {
            return self;
        }else{
            return [self subviewForPoint:point];
        }
    }
    return hitView;
}



#pragma mark -UIGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([self subviewForPoint:touchLocation] != self && _disapplerAfterSelection) {
        return YES;
    }
    
    return NO;
}


#pragma mark -setter



- (void)setHomeButtonView:(UIView *)homeButtonView
{
    if (_homeButtonView != homeButtonView) {
        _homeButtonView = homeButtonView;
    }
    //isDescendantOfView:是不是view的子控件或者子控件的子控件
    if ([_homeButtonView isDescendantOfView:self] == NO) {
        [self addSubview:_homeButtonView];
    }
}

- (NSArray *)buttons
{
    return [_buttonContainer copy];
}

@end
