//
//  AllTypeViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/29.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AllTypeViewController.h"

@interface AllTypeViewController ()
@property(nonatomic, copy)NSString * typeStr;
@property(nonatomic, copy)NSString * idStr;
@end

@implementation AllTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark
#pragma mark ======== 赋值
-(void)setSelectParams:(NSString *)typeStr idStr:(NSString *)idStr{
    _typeStr = typeStr;
    _idStr = idStr;
}

#pragma mark
#pragma mark ========== 请求数据


#pragma mark
#pragma mark ========== 基本页面设置
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
