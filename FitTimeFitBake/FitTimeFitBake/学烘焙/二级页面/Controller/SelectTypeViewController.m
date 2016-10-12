//
//  SelectTypeViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/30.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SelectTypeViewController.h"
#import "SelectTypeModel.h"
#import "SelectTypeTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

#define CELL_ID @"cell"
static int pageSize = 10;
@interface SelectTypeViewController ()<NetDataDownLoadDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSString * typeStr;
@property(nonatomic, copy)NSString * nameStr;
//数据
@property(nonatomic, copy)NSString * urlStr;
@property(nonatomic, strong)NSMutableDictionary * params;
@property(nonatomic, strong)NetDataDownLoad * dataDown;
@property(nonatomic, strong)NSDictionary * recpitDic;
@property(nonatomic, strong)NSMutableArray<SelectTypeModel *> *selectModelArray;
//searchbar
@property(nonatomic, strong)UISearchBar * searchBar;
//主页面
@property(nonatomic, strong)UITableView * myTableView;

@property(nonatomic, strong)UIButton * backButton;

@end

@implementation SelectTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForData];
    [self initForTitleView];
    [self initForMainView];
    [self refrush];
}

-(void)setSelectParams:(NSString *)typeStr idStr:(NSString *)idStr{
    _typeStr = typeStr;
    _nameStr = idStr;
}

#pragma mark
#pragma mark ========== 请求数据
-(NSMutableArray<SelectTypeModel *> *)selectModelArray{
    if (_selectModelArray == nil) {
        _selectModelArray = [[NSMutableArray alloc] init];
    }
    return _selectModelArray;
}
-(void)initForData{
    _urlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/search/getMoreRecipe"];
    _params = [[NSMutableDictionary alloc] init];
    _params[@"keyword"] = _nameStr;
    _params[@"pageIndex"] = @"0";
    _params[@"pageSize"] = @(10);
    _dataDown = [[NetDataDownLoad alloc] init];
    _dataDown.delegate = self;
    pageSize+=10;
    [_dataDown GET:_urlStr params:_params];
    
}
-(void)initForNewData{
    _urlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/search/getMoreRecipe"];
    _params = [[NSMutableDictionary alloc] init];
    _params[@"keyword"] = _nameStr;
    _params[@"pageIndex"] = @"0";
    _params[@"pageSize"] = @(pageSize);
    _dataDown = [[NetDataDownLoad alloc] init];
    _dataDown.delegate = self;
    pageSize+=10;
    [_dataDown GET:_urlStr params:_params];
}
-(void)downloadDataFinshed{
    _recpitDic = _dataDown.dataDic[@"data"][@"search"][@"list"][@"recipe"];
    self.selectModelArray = [SelectTypeModel mj_objectArrayWithKeyValuesArray:_recpitDic[@"data"]];
    [_myTableView reloadData];
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
-(void)downloadDataFailed{
#warning 错误view
    ZZQLog(@"Failed");
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}

#pragma mark
#pragma mark =========== 刷新
-(void)refrush{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initForData)];
    _myTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(initForNewData)];
    _myTableView.mj_footer = footer;
}

#pragma mark
#pragma mark =========== 设置titleView
-(void)initForTitleView{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width-80, 30)];
    _searchBar.text = _nameStr;
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    UIButton *btn=[_searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.navigationItem.titleView = _searchBar;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    拼接字符串，请求数据
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
}
#pragma mark
#pragma mark =========== 主页面设置
-(void)initForMainView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _selectModelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (cell == nil) {
        cell = [[SelectTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_ID];
    }
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellModel:_selectModelArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

//出现返回到顶部按钮
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 40) {
        if (_backButton != nil) {
            [_backButton removeFromSuperview];
        }
        [self initForTopButton];
    }else if(scrollView.contentOffset.y < 40){
        [_backButton removeFromSuperview];
    }
}

#pragma mark
#pragma mark ========== 显示返回top按钮
-(void)initForTopButton{
    _backButton = [MyBackTopButton backButton];
    _backButton.frame = CGRectMake(self.view.width-50, self.view.height*0.85, 40, 40);
    [_backButton addTarget:self action:@selector(returnToTop) forControlEvents:UIControlEventTouchUpInside];
    _backButton.layer.cornerRadius = 20;
    [self.view addSubview:_backButton];
}
-(void)returnToTop{
    [_myTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark
#pragma mark ========== 页面基本设置
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self initForTitleView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
