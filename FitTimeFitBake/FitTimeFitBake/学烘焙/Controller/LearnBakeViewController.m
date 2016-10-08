//
//  LearnBakeViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/20.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "LearnBakeViewController.h"
#import "LearnBakeView.h"
#import "ScrollViewDetailViewController.h"
#import "AllTypeViewController.h"
#import "PinShoppingViewController.h"
#import "ChoiceMenuViewController.h"
#import "FoundViewController.h"
#import "HotDetailViewController.h"
#import "RecipeGuyViewController.h"
#import "DailyActivityViewController.h"
#import "BigClassViewController.h"
#import "NiuDetailViewController.h"
#import "SelectTypeViewController.h"

@interface LearnBakeViewController ()

@property(nonatomic, strong)LearnBakeView * learnBakeView;

@end

@implementation LearnBakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    创建一个view就行，根据数据内的type决定cell的样式
    _learnBakeView = [[LearnBakeView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    [self.view addSubview:_learnBakeView];
    
    __weak typeof(self) weakSelf = self;
//    轮播图
    [_learnBakeView setGoToPicController:^(ScrollViewDetailViewController * vc, NSString * typeStr, NSString * idStr) {
        if ([typeStr isEqualToString:@"recipe"]) {
            [vc setNetWorkParams:typeStr idStr:idStr];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            PinShoppingViewController * pinVC = [[PinShoppingViewController alloc] init];
            [weakSelf.navigationController pushViewController:pinVC animated:YES];
        }
    }];
//    分类食谱
//    全部
    [_learnBakeView setGoToFoodTypeDetailController:^(AllTypeViewController * vc, NSString * typeStr, NSString * idStr) {
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
//    选中的
    [_learnBakeView setGoToSelectTypeDetailController:^(SelectTypeViewController * vc, NSString * typeStr, NSString * idStr) {
        [vc setSelectParams:typeStr idStr:idStr];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
        _learnBakeView.cell.timer.fireDate = [NSDate distantPast];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_learnBakeView.cell.timer != nil) {
        _learnBakeView.cell.timer.fireDate = [NSDate distantPast];
    }
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
