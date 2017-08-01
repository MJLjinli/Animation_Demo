//
//  MJLBubbleMenuView.h
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/31.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJLBubbleMenuView;
@protocol MJLBubbleMenuViewDelegate <NSObject>

@optional
- (void)bubbleMenuViewWillExpland:(MJLBubbleMenuView *)bullrMenuView;
- (void)bubbleMenuViewDidExpland:(MJLBubbleMenuView *)bullrMenuView;
- (void)bubbleMenuViewWillDisapper:(MJLBubbleMenuView *)bullrMenuView;
- (void)bubbleMenuViewDidDisapper:(MJLBubbleMenuView *)bullrMenuView;

@end

typedef enum : NSUInteger {
    ExDirectionLeft,
    ExDirectionRight,
    ExDirectionUp,
    ExDirectionDown
} ExDirection;



@interface MJLBubbleMenuView : UIView


@property(nonatomic,strong,readonly)NSArray *buttons;

@property(nonatomic,strong)UIView *homeButtonView;
@property(nonatomic,readonly)BOOL isDisappler;
@property(nonatomic,weak)id<MJLBubbleMenuViewDelegate>delegate;

/**
 菜单展开的方向,默认是向上
 */
@property(nonatomic,assign)ExDirection exDirection;

/**
 主页按钮是否有点击模糊的动画效果.默认是YES
 */
@property(nonatomic,assign)BOOL animatedHighlighting;

/**
 选择菜单之后,消失,默认YES
 */
@property(nonatomic,assign)BOOL disapplerAfterSelection;

/**
 动画时间
 */
@property(nonatomic,assign)CGFloat animationDuration;

/**
 没有点击时主页按钮的透明度
 */
@property(nonatomic,assign)CGFloat normalAlpha;

/**
 选中主页按钮的透明度
 */
@property(nonatomic,assign)CGFloat highlightAlpha;

/**
 按钮的间隔
 */
@property(nonatomic,assign)CGFloat buttonSpacing;



/**
 初始化创建

 @param frame frame
 @param exDirection 方向
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame expansionDirection:(ExDirection)exDirection;


/**
 创建菜单按钮

 @param buttons 按钮数组
 */
- (void)addButtons:(NSArray *)buttons;


@end
