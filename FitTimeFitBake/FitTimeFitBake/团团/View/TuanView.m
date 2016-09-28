//
//  TuanView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/27.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TuanView.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "TuanShopModel.h"
#import "TuanShopTableViewCell.h"

static int pageSize = 10;
@interface TuanView ()<NetDataDownLoadDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * myTableView;
@property(nonatomic, strong)NetDataDownLoad * downData;
@property(nonatomic, strong)NSArray<NSDictionary *> * tuanModelArray;
@property(nonatomic, strong)NSMutableArray<NSDictionary *> * allTuanModelArray;

@end

@implementation TuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForTuanData];
        [self initForTuanTableView];
        [self refrush];
    }
    return self;
}

#pragma mark
#pragma mark =========== 初始化数据
-(void)initForTuanData{
    pageSize = 10;
    NSString * url = @"http://api.hongbeibang.com/groupbuy/getAll";
    NSDictionary * params = @{@"pageIndex":@(0), @"pageSize":@(pageSize)};
    _downData = [[NetDataDownLoad alloc] init];
    _downData.delegate = self;
    [_downData GET:url params:params];
}

-(void)downloadDataFinshed{
    NSDictionary * dic = _downData.dataDic[@"data"];
    _tuanModelArray = dic[@"data"];
    _allTuanModelArray = [NSMutableArray arrayWithArray:_tuanModelArray];
    [_myTableView reloadData];
    
    [_myTableView.mj_header endRefreshing];
}
-(void)downloadDataFailed{
    ZZQLog(@"下载数据失败");
}
#pragma mark
#pragma mark ============ 刷新
-(void)refrush{
    NSMutableArray * images = [NSMutableArray array];
    for (NSInteger i = 0;  i < 8; i++) {
        NSString  * str = [NSString stringWithFormat:@"xl%ld", i];
        UIImage * image = [UIImage imageNamed:str];
        [images addObject:image];
    }
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(initForTuanData)];
    // 设置普通状态的动画图片
    [header setImages:images forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:images forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:images forState:MJRefreshStateRefreshing];
    _myTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    
}
#pragma mark
#pragma mark ========== 创建一个tableView
-(void)initForTuanTableView{
    _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_myTableView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
}

#pragma mark
#pragma mark =========== 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allTuanModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TuanShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[TuanShopTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellStyle:_allTuanModelArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 0;
    height += (self.width-20)/9*5+10;
    height += 30;
    height += 40;
    height += 10;
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

@end
