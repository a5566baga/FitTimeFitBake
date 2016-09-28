//
//  ShoppingViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/20.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ShoppingViewController.h"
#import "TuanView.h"

@interface ShoppingViewController ()
@property(nonatomic, strong)TuanView * tuanView;
@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initForTuanView];
}

#pragma mark
#pragma mark ========= 创建主视图
-(void)initForTuanView{
    _tuanView = [[TuanView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    _tuanView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tuanView];
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
