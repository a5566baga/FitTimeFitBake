//
//  ScrollViewDetailViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/29.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ScrollViewDetailViewController.h"
#import "MaterialModel.h"
#import "StepModel.h"
#import "ScrollviewDetailCell.h"
#import "ScrollviewDetailHeaderView.h"
#import <MJExtension.h>

#define CELL_ID @"ScrollViewDetailCELL"

@interface ScrollViewDetailViewController ()<NetDataDownLoadDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSString * myTypeStr;
@property(nonatomic, strong)NSString * myIdStr;

//数据
@property(nonatomic, strong)NetDataDownLoad * downLoad;
@property(nonatomic, strong)NSString * urlStr;
@property(nonatomic, strong)NSDictionary * dataDic;
@property(nonatomic, strong)NSDictionary * recipeDic;
@property(nonatomic, strong)NSArray<MaterialModel *> * materialArray;
@property(nonatomic, strong)NSArray<StepModel *> * stepArray;

//设置tableView
@property(nonatomic, strong)UITableView * tableView;

@end

@implementation ScrollViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForTItleView];
    [self initForData];
    [self initForMainView];
}
#pragma mark
#pragma mark ======== 设置题目页面
-(void)initForTItleView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"爱生活 爱烘焙";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
}

#pragma mark
#pragma mark ========= 获取url的参数
-(void)setNetWorkParams:(NSString *)typeStr idStr:(NSString *)idStr{
    _myTypeStr = typeStr;
    _myIdStr = idStr;
}

#pragma mark
#pragma mark =========== 请求参数
-(void)initForData{
    _urlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/get?contentId=%@", _myTypeStr, _myIdStr];
    _downLoad = [[NetDataDownLoad alloc] init];
    _downLoad.delegate = self;
    [_downLoad GET:_urlStr params:nil];
}
-(void)downloadDataFinshed{
    _dataDic = _downLoad.dataDic[@"data"];
    //    关键总的字典
    _recipeDic = _dataDic[@"recipe"];
    //    原料
    _materialArray = [MaterialModel mj_objectArrayWithKeyValuesArray:_recipeDic[@"material"]];
    //    步骤
    _stepArray = [StepModel mj_objectArrayWithKeyValuesArray:_recipeDic[@"step"]];
    [_tableView reloadData];
}
-(void)downloadDataFailed{
    //    数据出错
    ZZQLog(@"无网络，下载出错");
}

#pragma mark
#pragma mark ========== 设置主页面
-(void)initForMainView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark ============= tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _stepArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScrollviewDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (cell == nil) {
        cell = [[ScrollviewDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell setCellStyle:_stepArray[indexPath.row] index:indexPath.row+1];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = [self labelHeight:[UIFont systemFontOfSize:14] text:_stepArray[indexPath.row].text width:self.view.width-60];
    height += 10 + self.view.width*0.6/7*5+10;
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ScrollviewDetailHeaderView * headerView = [[ScrollviewDetailHeaderView alloc] init];
    [headerView setHeaderViewStyle:_recipeDic maters:_materialArray];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    先算
    float height = [self labelHeight:[UIFont systemFontOfSize:20] text:_recipeDic[@"title"] width:self.view.width-30];
    height += self.view.width/9*8;
    height += (self.view.width-30)/5+30;
    height += 10+15+10+5+5+10;
    height += [self labelHeight:[UIFont systemFontOfSize:13] text:_recipeDic[@"coverSummary"] width:self.view.width-30]+10;
    height += 20+30;
    height += 20+20+20+20;
    if (_materialArray.count > 1 && ![_materialArray[1].weight isEqualToString:@""]) {
        height += _materialArray.count*(20+10)+20;
    }else{
        NSMutableString * str = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < _materialArray.count; i++) {
            [str appendFormat:@"%@ ", _materialArray[i].name];
        }
        height += [self labelHeight:[UIFont systemFontOfSize:14] text:str width:self.view.width-30]+20;
    }
    height += 30;
    return height+20;
}

#pragma mark
#pragma mark =========== 工具类
-(CGFloat)labelHeight:(UIFont *)font text:(NSString *)text width:(float)width{
    CGSize mySize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

#pragma mark
#pragma mark ========== 页面基础设置
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
