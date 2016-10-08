//
//  LearnBakeView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/21.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "LearnBakeView.h"
#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

#import "LearnBakeModel.h"

#define CellID @"myCell"
@interface LearnBakeView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)AFHTTPSessionManager * manager;

@property(nonatomic, strong)NSArray<LearnBakeModel *> * modelsArray;


@end

@implementation LearnBakeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
        [self initForData];
    }
    return self;
}

#pragma mark
#pragma mark ========= 创建一个tableView
-(void)initForView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    [self addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark
#pragma mark ========== 初始化数据
//懒加载
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        NSSet * set = [[NSSet alloc] initWithObjects:@"text/javascript", @"application/json", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}
-(void)initForData{
    NSString * url = @"http://api.hongbeibang.com/index/get";
    [self.manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dataDic = responseObject[@"data"];
        _modelsArray = [LearnBakeModel mj_objectArrayWithKeyValuesArray:dataDic[@"category"]];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark
#pragma mark ========== tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     _cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (_cell == nil) {
        _cell = [[LearnBakeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    for (UIView *view in _cell.subviews) {
        [view removeFromSuperview];
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_cell setCellStyle:_modelsArray[indexPath.section]];
    
    __weak typeof(self) mySelf = self;
//    轮播图
    [_cell setGoToPicDetail:^(ScrollViewDetailViewController * vc, NSString * type, NSString * idStr) {
        mySelf.goToPicController(vc, type, idStr);
    }];
    
//    分类食谱
    [_cell setGoToFoodTypeDetail:^(AllTypeViewController * vc, NSString * type, NSString * idStr) {
        mySelf.goToFoodTypeDetailController(vc, type, idStr);
    }];
    [_cell setGoToSelectTypeDetail:^(SelectTypeViewController * vc, NSString * type, NSString * idStr) {
        mySelf.goToSelectTypeDetailController(vc, type, idStr);
    }];
    
    return _cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_modelsArray[indexPath.section].title isEqualToString:@"轮播图"]) {
        return self.width/16*9;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"分类食谱"]){
        return 180;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"拼团"]){
        return 200;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"精选菜单"]){
        return self.width/2.5+50+20;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"发现"]){
        return 50+10+(self.width-50)/4+20;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"热门榜单"]){
        return 50+(50+10)*_modelsArray[indexPath.section].item.count;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"食谱达人"]){
        return 50+50+10;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"日常活动"]){
        return 50+30*_modelsArray[indexPath.section].item.count;
    }else if ([_modelsArray[indexPath.section].title isEqualToString:@"大课堂"]){
        return 50+50*_modelsArray[indexPath.section].item.count;
    }
    else if([_modelsArray[indexPath.section].title isEqualToString:@"友情链接"]){
        return 50+(self.width-20)/4;
    }else
        return self.width/2.5+50+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

@end
