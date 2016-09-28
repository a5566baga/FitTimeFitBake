//
//  QuestionViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/20.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionView.h"

#define  WIDTH self.view.width/3
#define  HEIGHT 35

@interface QuestionViewController ()
//title上的button
@property(nonatomic, strong)UIBarButtonItem * mailButton;
@property(nonatomic, strong)UIBarButtonItem * addButton;
//分栏的button
@property(nonatomic, strong)UIButton * dynamicButton;
@property(nonatomic, strong)UIButton * hotButton;
@property(nonatomic, strong)UIButton * noAnswerButton;
@property(nonatomic, strong)UIView * redLineView;
//创建tableView
@property(nonatomic, strong)QuestionView * questionView;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initForTitleView];
    [self initForMainView];
    [self initForTableView];
}
#pragma mark
#pragma mark ========== 导航栏的按钮
-(void)initForTitleView{
    _mailButton = [UIBarButtonItem itemWithImage:@"app_images_navigationbar_navigation_email" HightImage:@"app_images_navigationbar_navigation_email" target:self action:@selector(mailAction)];
    self.navigationItem.leftBarButtonItem = _mailButton;
    
    _addButton = [UIBarButtonItem itemWithImage:@"app_images_navigationbar_navigation_add" HightImage:@"app_images_navigationbar_navigation_add" target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = _addButton;
}
-(void)mailAction{
#warning 到我的邮箱信息
}
-(void)addAction{
#warning 发送新的信息
}

#pragma mark
#pragma mark ========== 三个Button和tableView
-(void)initForMainView{
    _dynamicButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    [_dynamicButton setTitle:@"动态" forState:UIControlStateNormal];
    [_dynamicButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_dynamicButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _dynamicButton.selected = YES;
    [_dynamicButton setBackgroundColor:[UIColor whiteColor]];
    _dynamicButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_dynamicButton addTarget:self action:@selector(dynamicAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dynamicButton];
    
    _hotButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH, 64, WIDTH, HEIGHT)];
    [_hotButton setTitle:@"最热" forState:UIControlStateNormal];
    [_hotButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_hotButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _hotButton.selected = NO;
    [_hotButton setBackgroundColor:[UIColor whiteColor]];
    _hotButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_hotButton addTarget:self action:@selector(hotAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_hotButton];
    
    _noAnswerButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH*2, 64, WIDTH, HEIGHT)];
    [_noAnswerButton setTitle:@"未回答" forState:UIControlStateNormal];
    [_noAnswerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_noAnswerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _noAnswerButton.selected = NO;
    [_noAnswerButton setBackgroundColor:[UIColor whiteColor]];
    _noAnswerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_noAnswerButton addTarget:self action:@selector(noAnswerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_noAnswerButton];
    
    _redLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+HEIGHT-2, WIDTH, 2)];
    _redLineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redLineView];
}
-(void)dynamicAction:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        _dynamicButton.selected = !_dynamicButton.selected;
        _hotButton.selected = NO;
        _noAnswerButton.selected = NO;
        _redLineView.x = btn.x;
    }];
}
-(void)hotAction:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        _hotButton.selected = !_hotButton.selected;
        _dynamicButton.selected = NO;
        _noAnswerButton.selected = NO;
        _redLineView.x = btn.x;
    }];
}
-(void)noAnswerAction:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        _noAnswerButton.selected = !_noAnswerButton.selected;
        _dynamicButton.selected = NO;
        _hotButton.selected = NO;
        _redLineView.x = btn.x;
    }];
}

#pragma mark
#pragma mark ============== 创建tableView
-(void)initForTableView{
    _questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, 64+HEIGHT, self.view.width, self.view.height-64-49)];
    _questionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_questionView];
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
