//
//  BakeWayViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/20.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BakeWayViewController.h"
#import "BakeView.h"

@interface BakeWayViewController ()

@property(nonatomic, strong)BakeView * bakeView;

@end

@implementation BakeWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    创建导航视图
    [self initForTitleView];
//    创建主视图
    [self initForView];
}
#pragma mark
#pragma mark ========== 导航栏的图标
-(void)initForTitleView{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"app_images_navigationbar_navigation_email" HightImage:@"app_images_navigationbar_navigation_email" target:self action:@selector(emailAction:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"app_images_navigationbar_navigation_add" HightImage:@"app_images_navigationbar_navigation_add" target:self action:@selector(addAction:)];
    
}
-(void)emailAction:(UIButton *)button{
    
}
-(void)addAction:(UIButton *)button{
    
}

#pragma mark
#pragma mark ========= 主界面
-(void)initForView{
    _bakeView = [[BakeView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    _bakeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bakeView];
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
