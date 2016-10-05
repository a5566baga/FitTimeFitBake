//
//  ScrollViewDetailViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/29.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ScrollViewDetailViewController.h"

@interface ScrollViewDetailViewController ()

@property(nonatomic, strong)NSString * myTypeStr;
@property(nonatomic, strong)NSString * myIdStr;

@end

@implementation ScrollViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForTItleView];
}
#pragma mark
#pragma mark ======== 设置题目页面
-(void)initForTItleView{
    self.title = @"爱生活 爱烘焙";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
}
#pragma mark
#pragma mark ========= 获取url的参数
-(void)setNetWorkParams:(NSString *)typeStr idStr:(NSString *)idStr{
    _myTypeStr = typeStr;
    _myIdStr = idStr;
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
