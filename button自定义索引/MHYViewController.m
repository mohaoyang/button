//
//  MHYViewController.m
//  button自定义索引
//
//  Created by jshtmhy on 16/12/19.
//  Copyright © 2016年 jshtmhy. All rights reserved.
//

#import "MHYViewController.h"
#import "JSHTWeek.h"
//屏幕宽
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

//屏幕高
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height
@interface MHYViewController ()<UIGestureRecognizerDelegate> {
    NSInteger lastTag;
}
@property (nonatomic,strong) NSMutableArray *listDataSource;
@property (nonatomic,strong) UIView *weekView;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) NSString *currentDate;//当前日期
@property (nonatomic, copy) NSString *dateString;//明天
@end

@implementation MHYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化 tag值
    lastTag = -1;
    self.view.backgroundColor = [UIColor blackColor];
    // 所有索引按钮的父视图
    self.weekView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HIGHT/2, 39,SCREEN_HIGHT/2)];
    self.weekView.tag = 10000;
    self.weekView.backgroundColor =[UIColor colorWithRed:247 green:247 blue:247 alpha:1] ;;
    [self.view addSubview:self.weekView];
    // 遍历循环添加按钮到父视图上
    for (int i = 0; i < [JSHTWeek getDate].count; i ++) {
        UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weekBtn.frame = CGRectMake(0,i*SCREEN_HIGHT/2/7+19,38,30);
        weekBtn.tag = i+100;
        if (i==0) {
            weekBtn.selected = YES;
            self.selectIndex = 100;
            [weekBtn setTitle:@"今" forState:UIControlStateNormal];
        }else {
            NSArray *weekArray = [[JSHTWeek getDate][i] componentsSeparatedByString:@";"];
            [weekBtn setTitle:weekArray.lastObject forState:UIControlStateNormal];
        }
        [weekBtn addTarget:self action:@selector(weekClickData:) forControlEvents:UIControlEventTouchUpInside];
        [weekBtn setTitleColor:[UIColor colorWithRed:68.0f/255.0 green:68.0f/255.0 blue:68.0f/255.0 alpha:1.0] forState:UIControlStateNormal];
        [weekBtn setTitleColor:[UIColor colorWithRed:66.0f/255.0 green:189.0f/255.0 blue:85.0f/255.0 alpha:1.0] forState:UIControlStateSelected];
        [self.weekView addSubview:weekBtn];
    }
    // 手指滑动触发
    UIPanGestureRecognizer *singlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDo:)];
    [self.weekView addGestureRecognizer:singlePan];
}
- (void)panDo:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *weekView = [self.view viewWithTag:10000];
    // 获取平移手势对象在索引按钮父视图的位置点
    CGPoint curPoint = [gestureRecognizer locationInView:weekView];
    // 循环所有父视图中的所有按钮视图
    for (UIView *view in weekView.subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            // 如果该点包含在某一个UIButton的Rect里面，并且最后的按钮tag值不等于当前的tag值
            if (CGRectContainsPoint(view.frame, curPoint) && lastTag != button.tag) {
                lastTag = button.tag;
                UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
                btn.selected = NO;
                self.selectIndex = button.tag;
                UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:button.tag];
                currentSelectBtn.selected = YES;
                NSLog(@">>>>>>>>>>>>>>%lu",button.tag);
            }
        }
    }
}

- (void)weekClickData:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button.tag != lastTag) {
        lastTag = button.tag;
        [self didSelectWeekIndex:button .tag];
        NSLog(@">>>>>>>>>>>>>>%lu",button.tag);
    }
}
- (void)didSelectWeekIndex:(NSInteger)index{
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.selectIndex];
    btn.selected = NO;
    self.selectIndex = index;
    UIButton *currentSelectBtn = (UIButton *)[self.view viewWithTag:index];
    currentSelectBtn.selected = YES;
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
