//
//  QuestionView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "QuestionView.h"
#import "QuestionModel.h"
#import "QuestionTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

static int pageSize = 10;
#define MAIN_WIDTH self.width-70

@interface QuestionView ()<NetDataDownLoadDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NetDataDownLoad * downLoad;
@property(nonatomic, strong)NSMutableArray<QuestionModel *> * allModelArray;
@property(nonatomic, strong)UITableView * quesTableView;

@end

@implementation QuestionView

-(void)setSelectTypeStr:(NSString *)type{
    _typeStr = type;
    [self initForData];
    _quesTableView.contentOffset = CGPointMake(0, 0);
}
-(NSString *)typeStr{
    if (_typeStr == nil) {
        _typeStr = @"getNew";
    }
    return _typeStr;
}
-(NetDataDownLoad *)downLoad{
    if (_downLoad == nil) {
        _downLoad = [[NetDataDownLoad alloc] init];
        _downLoad.delegate = self;
    }
    return _downLoad;
}

#pragma mark
#pragma mark =========== 初始化数据
-(void)initForData{
    pageSize = 10;
    NSString * urlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/question/%@", self.typeStr];
    NSDictionary * params = @{@"pageIndex":@(0), @"pageSize": @(pageSize)};
    [self.downLoad GET:urlStr params:params];
}
-(void)initForNewData{
    pageSize += 10;
    NSString * urlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/question/%@", self.typeStr];
    NSDictionary * params = @{@"pageIndex":@(0), @"pageSize": @(pageSize)};
    [self.downLoad GET:urlStr params:params];
}
-(void)downloadDataFinshed{
    NSDictionary * contentDic = self.downLoad.dataDic[@"data"][@"content"];
    NSArray * models = [QuestionModel mj_objectArrayWithKeyValuesArray:contentDic[@"data"]];
    _allModelArray = [NSMutableArray arrayWithArray:models];
    [_quesTableView reloadData];
    [_quesTableView.mj_header endRefreshing];
    [_quesTableView.mj_footer endRefreshing];
}
-(void)downloadDataFailed{
    ZZQLog(@"Failed");
    [_quesTableView.mj_header endRefreshing];
    [_quesTableView.mj_footer endRefreshingWithNoMoreData];
}
-(void)initForQuestinTableView{
    _quesTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _quesTableView.showsVerticalScrollIndicator = NO;
    _quesTableView.showsHorizontalScrollIndicator = NO;
    _quesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_quesTableView];
    _quesTableView.delegate = self;
    _quesTableView.dataSource = self;
}
#pragma mark
#pragma mark ========= 刷新设置
-(void)refrush{
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
    _quesTableView.mj_header = header;
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
    _quesTableView.mj_footer = footer;
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self initForData];
    [self initForQuestinTableView];
    [self refrush];
}

#pragma mark
#pragma mark =========== delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"quesCell"];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"quesCell"];
    }
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellModel:_allModelArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = [self labelHeight:indexPath];
    if(height > 34){
        height = 34;
    }
    height += 20 + 30;
    return height;
}
-(CGFloat)labelHeight:(NSIndexPath *)indexPath{
    CGSize mySize = CGSizeMake(MAIN_WIDTH, CGFLOAT_MAX);
    CGSize size = [_allModelArray[indexPath.row].coverTitle boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}

@end
