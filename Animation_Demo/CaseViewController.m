//
//  CaseViewController.m
//  Animation_Demo
//
//  Created by 马金丽 on 17/7/27.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "CaseViewController.h"

#import "FireworksBtn.h"
#import "MJLBubbleMenuView.h"
@interface CaseViewController ()


@property(nonatomic,strong)FireworksBtn *fireBtn;


@property(nonatomic,strong)UILabel *menuLabel;

@end

@implementation CaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fireBtn = [[FireworksBtn alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2- 25, 100, 50, 50)];
    _fireBtn.particleImage = [UIImage imageNamed:@"mjl_Sparkle"];
    _fireBtn.particleScale = 0.05;
    _fireBtn.particleScaleRange = 0.02;
    [_fireBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    [_fireBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fireBtn];
    UILabel *homeLabel = [self createHomeButtonView];

    MJLBubbleMenuView *menuView = [[MJLBubbleMenuView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - self.menuLabel.frame.size.width-20, 200, self.menuLabel.frame.size.width, self.menuLabel.frame.size.height) expansionDirection:ExDirectionLeft];
    menuView.homeButtonView = homeLabel;
//    menuView.backgroundColor = [UIColor blueColor];
    [menuView addButtons:[self createDemoButtonArray]];
    [self.view addSubview:menuView];
}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    
    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(dwBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}


//菜单按钮
- (void)dwBtnClick:(UIButton *)sender
{
    NSLog(@"点击:%ld",(long)sender.tag);
}
//点赞
- (void)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_fireBtn popOutsideWithDuration:0.5];
        [sender setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [_fireBtn animate];
    }else{
        [_fireBtn popInsideWithDuration:0.5];
        [_fireBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UILabel *)menuLabel
{
    if (!_menuLabel) {
        _menuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
        _menuLabel.text = @"点";
        _menuLabel.layer.cornerRadius = 20;
        _menuLabel.layer.masksToBounds = YES;
        _menuLabel.backgroundColor = [UIColor redColor];
    }
    return _menuLabel;
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
