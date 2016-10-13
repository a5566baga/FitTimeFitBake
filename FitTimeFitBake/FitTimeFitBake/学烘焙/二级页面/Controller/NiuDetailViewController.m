//
//  NiuDetailViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/30.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "NiuDetailViewController.h"
#import "NiuModel.h"
#import "BakeWayModel.h"
#import "NiuTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

static int pageSize = 10;
@interface NiuDetailViewController ()<NetDataDownLoadDelegate, UITableViewDelegate, UITableViewDataSource>

//参数
@property(nonatomic, copy)NSString * typeStr;
@property(nonatomic, copy)NSString * idStr;
//数据请求参数
@property(nonatomic, copy)NSString * upUrlStr;
@property(nonatomic, copy)NSString * downUrlStr;
@property(nonatomic, strong)NSMutableDictionary * downParamsDic;
@property(nonatomic, strong)NSArray<NiuModel *> * niuModelArray;
@property(nonatomic, strong)NSArray * niuArray;
@property(nonatomic, strong)NSArray<BakeWayModel *> * nowModelArray;
@property(nonatomic, strong)NSArray<BakeWayModel *> * hotModelArray;
@property(nonatomic, strong)NetDataDownLoad  * upDown;
@property(nonatomic, strong)NetDataDownLoad  * downDown;
@property(nonatomic, assign)NSInteger downNum;
//页面
@property(nonatomic, strong)UITableView * myTableView;

@end

@implementation NiuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForView];
    [self refrush];
}

#pragma mark
#pragma mark ========== 赋值
-(void)setSelectParams:(NSString *)typeStr idStr:(NSString *)idStr{
    _typeStr = typeStr;
    _idStr = idStr;
    
//    上面的数据h ttp://api.hongbeibang.com/tribe/get?tribeId=10001
    _upUrlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/get?tribeId=%@", _typeStr, _idStr];
    
//    下面的数据 最新 h ttp://api.hongbeibang.com/tribe/getDish?tribeId=10001&sort=new&pageIndex=0&pageSize=10
    _downUrlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/getDish", _typeStr];
    _downParamsDic = [[NSMutableDictionary alloc] init];
    _downParamsDic[@"tribeId"] = _idStr;
    _downParamsDic[@"sort"] = @"new";
    _downParamsDic[@"pageIndex"] = @(0);
    
//    最热 htt p://api.hongbeibang.com/tribe/getDish?tribeId=10001&sort=hot&pageIndex=0&pageSize=10
    
    [self initForData];
}

#pragma mark
#pragma mark ========== 请求数据
-(void)initForData{
    pageSize = 10;
    _downParamsDic[@"pageSize"] = @(pageSize);
    
    _upDown = [[NetDataDownLoad  alloc] init];
    _upDown.delegate = self;
    [_upDown GET:_upUrlStr params:nil];
    
    _downDown = [[NetDataDownLoad alloc] init];
    _downDown.delegate = self;
    [_downDown GET:_downUrlStr params:_downParamsDic];
    
    pageSize += 10;
}
-(void)initForNewData{
    [_upDown GET:_upUrlStr params:nil];
    [_downDown GET:_downUrlStr params:_downParamsDic];
    pageSize += 10;
}
-(void)downloadDataFinshed{
//    成功
//    上边数据
    NSDictionary * upDic = _upDown.dataDic[@"data"];
    _niuModelArray = [NiuModel mj_objectArrayWithKeyValuesArray:upDic[@"artifact"]];
    _niuArray = [upDic[@"itemType"] allKeys];
//    下面的数据
    NSDictionary * downDic = _downDown.dataDic[@"data"];
    if ([_downParamsDic[@"sort"] isEqualToString:@"hot"]) {
        _hotModelArray = [BakeWayModel mj_objectArrayWithKeyValuesArray:downDic[@"data"]];
        _downNum = _hotModelArray.count;
    }else{
        _nowModelArray = [BakeWayModel mj_objectArrayWithKeyValuesArray:downDic[@"data"]];
        _downNum = _nowModelArray.count;
    }
    
    [_myTableView reloadData];
}
-(void)downloadDataFailed{
//    失败
    ZZQLog(@"data Failed");
}

#pragma mark
#pragma mark =========== 刷新
-(void)refrush{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initForData)];
    _myTableView.mj_header = header;
    
    MJRefreshAutoFooter * footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(initForNewData)];
    _myTableView.mj_footer = footer;
}

#pragma mark
#pragma mark ============ 创建shitu
-(void)initForView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}
//代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return _downNum;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NiuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NiuTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    return cell;
}
#pragma mark
#pragma mark =========== 基本设置
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"神器部落";
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
