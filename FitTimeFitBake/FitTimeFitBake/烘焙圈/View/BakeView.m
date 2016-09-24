//
//  BakeView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BakeView.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "BakeWayModel.h"
#import "BakeWayHeaderView.h"
#import "BakeWayTableViewCell.h"

#define CELL_ID @"bakeWayCell"
static int page = 10;
@interface BakeView ()<UITableViewDelegate, UITableViewDataSource, NetDataDownLoadDelegate>

@property(nonatomic, strong)BakeWayHeaderView * headerView;
@property(nonatomic, strong)NetDataDownLoad * dataDown;
@property(nonatomic, strong)UITableView * myTableView;
@property(nonatomic, strong)NSString * url;
@property(nonatomic, strong)NSMutableDictionary * params;
@property(nonatomic, strong)NSArray<BakeWayModel *> * bakeWayModelArray;
@property(nonatomic, strong)NSMutableArray<BakeWayModel *> * allBakeWayModelArray;

@end

@implementation BakeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForTableView];
        [self initForData];
        [self initForRefrush];
    }
    return self;
}

#pragma mark
#pragma mark ========== 请求数据(新数据)
-(void)initForData{
    _url = @"http://api.hongbeibang.com/feed/getNew";
    _params = [NSMutableDictionary dictionary];
    _params[@"pageIndex"] = @(0);
    _params[@"pageSize"] = @(10);
    _dataDown = [[NetDataDownLoad alloc] init];
    _dataDown.delegate = self;
    [_dataDown GET:_url params:_params];
}
#pragma mark
#pragma mark ========== 请求新数据
-(void)initForNewData{
    _url = @"http://api.hongbeibang.com/feed/getNew";
    _params = [NSMutableDictionary dictionary];
    _params[@"pageIndex"] = @(0);
    _params[@"pageSize"] = @(page);
    _dataDown = [[NetDataDownLoad alloc] init];
    _dataDown.delegate = self;
    [_dataDown GET:_url params:_params];
}
-(void)downloadDataFinshed{
    _bakeWayModelArray = [BakeWayModel mj_objectArrayWithKeyValuesArray:_dataDown.dataDic[@"data"][@"content"][@"data"]];
    _allBakeWayModelArray = [NSMutableArray arrayWithArray:_bakeWayModelArray];
    NSLog(@"%ld", _allBakeWayModelArray.count);
    page += 10;
    [self.myTableView reloadData];
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
-(void)downloadDataFailed{
#warning 失败的时候提示信息没有添加
    NSLog(@"Failed");
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}

#pragma mark
#pragma mark ========== 刷新控件
-(void)initForRefrush{
    NSMutableArray * images = [NSMutableArray array];
    for (NSInteger i = 0;  i < 8; i++) {
        NSString  * str = [NSString stringWithFormat:@"xl%ld", i];
        UIImage * image = [UIImage imageNamed:str];
        [images addObject:image];
    }
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(initForData)];
    // 设置普通状态的动画图片
    [header setImages:images forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:images forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:images forState:MJRefreshStateRefreshing];
    _myTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    
    
    NSMutableArray * footerImages = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        NSString * imgStr = [NSString stringWithFormat:@"sl%ld", i];
        UIImage * img = [UIImage imageNamed:imgStr];
        [footerImages addObject:img];
    }
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(initForNewData)];
    [footer setImages:footerImages forState:MJRefreshStateIdle];
    [footer setImages:footerImages forState:MJRefreshStatePulling];
    [footer setImages:footerImages forState:MJRefreshStateRefreshing];
    _myTableView.mj_footer = footer;
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden = YES;
}

#pragma mark
#pragma mark ========== 创建tableView
-(void)initForTableView{
    _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self addSubview:_myTableView];
}
#pragma mark
#pragma mark ============ tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allBakeWayModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BakeWayTableViewCell * bakeWayCell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (bakeWayCell == nil) {
        bakeWayCell = [[BakeWayTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    for (UIView * view in bakeWayCell.subviews) {
        [view removeFromSuperview];
    }
    
    return bakeWayCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[BakeWayHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/16*9)];
    _headerView.backgroundColor = [UIColor orangeColor];
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.width/16*9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
@end
