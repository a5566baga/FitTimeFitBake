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
#import "PicItem.h"

#define CELL_ID @"bakeWayCell"
static int page = 10;
@interface BakeView ()<UITableViewDelegate, UITableViewDataSource, NetDataDownLoadDelegate>

@property(nonatomic, strong)BakeWayHeaderView * headerView;
@property(nonatomic, strong)NSMutableArray<PicItem *> * itemsArray;
@property(nonatomic, strong)NSMutableArray * picArray;
@property(nonatomic, strong)NetDataDownLoad * downLoad;

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
        [self initForHeaderViewData];
        [self initForRefrush];
    }
    return self;
}

-(void)initForHeaderViewData{
    NSString * url = @"http://api.hongbeibang.com/feed/getCategory";
    _downLoad = [[NetDataDownLoad alloc] init];
    _downLoad.delegate = self;
    [_downLoad GET:url params:nil];
}

#pragma mark
#pragma mark ========== 请求数据(新数据)
-(void)initForData{
    page = 10;
    _url = @"http://api.hongbeibang.com/feed/getNew";
    _params = [NSMutableDictionary dictionary];
    _params[@"pageIndex"] = @(0);
    _params[@"pageSize"] = @(page);
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
//    NSLog(@"%ld", _allBakeWayModelArray.count);
    [self.myTableView reloadData];
    page += 10;
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    
    NSDictionary * dataDic = _downLoad.dataDic[@"data"];
    NSArray * categoryArr = dataDic[@"category"];
    _itemsArray = [PicItem mj_objectArrayWithKeyValuesArray:categoryArr.firstObject[@"item"]];
    NSMutableArray * tempPic = [NSMutableArray array];
    for (NSInteger i = 0; i < _itemsArray.count; i++) {
        [tempPic addObject:[_itemsArray[i] image]];
    }
    _picArray = [NSMutableArray arrayWithArray:tempPic];
    [_picArray addObject:tempPic.firstObject];
    [_picArray insertObject:tempPic.lastObject atIndex:0];
}
-(void)downloadDataFailed{
#warning 失败的时候提示信息没有添加
    NSLog(@"Failed");
    UIImageView * error = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    error.image = [UIImage imageNamed:@"noNetWork"];
    error.center = self.center;
    [self addSubview:error];
    
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
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    bakeWayCell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView * view in bakeWayCell.subviews) {
        [view removeFromSuperview];
    }
    [bakeWayCell setCellStyle:_allBakeWayModelArray[indexPath.row]];
    return bakeWayCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self getRowHeight:indexPath];
}
//计算cell的高度
-(CGFloat)getRowHeight:(NSIndexPath *)indexPath{
    //    topmargin:10 用户头像高:40 用户介绍:动态变化 底边:10 图片高度
//    描述高度
    float leftMargin = self.width-70;
    float desHeight = [self labelHeight:indexPath];
    if (desHeight > 34) {
        desHeight = 34;
    }
//    图片高度
    float showPicWidth = (leftMargin-30-2*3)/3;
    NSInteger count = _allBakeWayModelArray[indexPath.row].image.count;
    NSInteger row = 0;
    if (count <= 3) {
        row = 1;
    }else if(count <= 6){
        row = 2;
    }else{
        row = 3;
    }
    float showPicAllWidth = row * (showPicWidth+3);
    if (_allBakeWayModelArray[indexPath.row].image.count == 1) {
        showPicAllWidth = 2*(showPicWidth+3);
    }
//    点赞区域 30
//    评论区
    Comment_bakeWay * commnt = _allBakeWayModelArray[indexPath.row].comment;
    NSArray<Data_bakeWay *> * dataArray = commnt.data;
    float allHeight = 0;
    NSString * str = @"回复";
    float commentLineHeight = 0;
    float commentTopMargin = 15;
    for (NSInteger i = 0; i < dataArray.count; i++) {
        //        回复内容
        NSString * commentText = dataArray[i].text;
        //        第一个用户
        NSString * commentClientName = dataArray[i].commentClientName;
        //        第二个用户
        NSString * clientName = dataArray[i].clientName;
        NSString * textStr = [NSString stringWithFormat:@"%@ %@ %@:%@", commentClientName, str, clientName, commentText];
        commentLineHeight = [self commentHeight:textStr]+10;
        
        allHeight += commentLineHeight;
    }
    if (allHeight != 0) {
        allHeight = allHeight+2*commentTopMargin;
    }
//    底边灰边
    return 10+40+10+desHeight+showPicAllWidth+30+allHeight+10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView = [[BakeWayHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/8*3+40)];
    _headerView.backgroundColor = [UIColor orangeColor];
    [_headerView setPicArray:_picArray];
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.width/8*3+30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

#pragma mark
#pragma mark =========== 计算高度
-(CGFloat)labelHeight:(NSIndexPath *)indexPath{
    CGSize mySize = CGSizeMake(self.width-70, CGFLOAT_MAX);
    CGSize size = [_allBakeWayModelArray[indexPath.row].introduce boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}
//计算评论高度
-(CGFloat)commentHeight:(NSString *)text{
    CGSize mySize = CGSizeMake(self.width-70-30, CGFLOAT_MAX);
    CGSize size = [text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}
@end
