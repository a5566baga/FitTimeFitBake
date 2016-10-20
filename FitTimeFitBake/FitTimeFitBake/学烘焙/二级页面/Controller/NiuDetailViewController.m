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
#import "BakeWayTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

static int pageSize = 0;
static NSInteger seleNume = 0;
static NSInteger indexs = 0;
@interface NiuDetailViewController ()<NetDataDownLoadDelegate, UITableViewDelegate, UITableViewDataSource>

//参数
@property(nonatomic, copy)NSString * typeStr;
@property(nonatomic, copy)NSString * idStr;
@property(nonatomic, copy)NSString * seletType;
//@property(nonatomic, assign)NSInteger index;
//数据请求参数
@property(nonatomic, copy)NSString * upUrlStr;
@property(nonatomic, copy)NSString * downUrlStr;
@property(nonatomic, strong)NSMutableDictionary * downParamsDic;
@property(nonatomic, strong)NSArray<NiuModel *> * niuModelArray;
@property(nonatomic, strong)NSMutableArray * niuArray;
@property(nonatomic, strong)NSMutableArray<BakeWayModel *> * modelArray;
@property(nonatomic, strong)NetDataDownLoad  * upDown;
@property(nonatomic, strong)NetDataDownLoad  * downDown;
@property(nonatomic, assign)NSInteger downNum;
//页面
@property(nonatomic, strong)UITableView * myTableView;
@property(nonatomic, strong)UISegmentedControl * segmentView;

@property(nonatomic, strong)BakeWayTableViewCell * bakeCell;
@property(nonatomic, strong)NiuTableViewCell * niuCell;

@property(nonatomic, strong)UIButton * topButton;

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
    _modelArray = [[NSMutableArray alloc] init];
    //    上面的数据h ttp://api.hongbeibang.com/tribe/get?tribeId=10001
    _upUrlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/get?tribeId=%@", _typeStr, _idStr];
    
    //    下面的数据 最新 h ttp://api.hongbeibang.com/tribe/getDish?tribeId=10001&sort=new&pageIndex=0&pageSize=10
    _seletType = @"getDish";
    _downUrlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/%@", _typeStr, _seletType];
    _downParamsDic = [[NSMutableDictionary alloc] init];
    _downParamsDic[@"tribeId"] = _idStr;
    _downParamsDic[@"sort"] = @"new";
    _downParamsDic[@"pageIndex"] = @(0);
    _downParamsDic[@"pageSize"] = @(10);
    
    //    最热 htt p://api.hongbeibang.com/tribe/getDish?tribeId=10001&sort=hot&pageIndex=0&pageSize=10
    
    [self initForData];
}

#pragma mark
#pragma mark ========== 请求数据
-(void)initForData{
    pageSize = 0;
    _downParamsDic[@"pageIndex"] = @(0);
    
    _upDown = [[NetDataDownLoad  alloc] init];
    _upDown.delegate = self;
    [_upDown GET:_upUrlStr params:nil];
    
    _downDown = [[NetDataDownLoad alloc] init];
    _downDown.delegate = self;
    [_downDown GET:_downUrlStr params:_downParamsDic];
    
    pageSize += 10;
}
-(void)initForNewData{
    _downParamsDic[@"pageIndex"] = @(pageSize);
    [_upDown GET:_upUrlStr params:nil];
    [_downDown GET:_downUrlStr params:_downParamsDic];
    pageSize += 10;
}
-(void)downloadDataFinshed{
    //    成功
    //    上边数据
    NSDictionary * upDic = _upDown.dataDic[@"data"];
    _niuModelArray = [NiuModel mj_objectArrayWithKeyValuesArray:upDic[@"artifact"]];
    NSMutableArray* keys = [NSMutableArray arrayWithArray:[upDic[@"itemType"] allKeys]];
    for (NSInteger i = 0; i < keys.count; i++) {
        for (NSInteger j = 0; j < keys.count-i-1; j++) {
            if (keys[j] > keys[j+1]) {
                NSNumber * temp = keys[j];
                keys[j] = keys[j+1];
                keys[j+1] = temp;
            }
        }
    }
    
    _niuArray = [[NSMutableArray alloc] init];
    for (NSNumber * key in keys) {
        [_niuArray addObject:[upDic[@"itemType"] objectForKey:key] ];
    }
    //    下面的数据
    NSDictionary * downDic = _downDown.dataDic[@"data"];
    if (pageSize > 10) {
        NSArray * arr = [BakeWayModel mj_objectArrayWithKeyValuesArray:downDic[@"data"]];
        [_modelArray addObjectsFromArray:arr];
    }else{
        _modelArray = [BakeWayModel mj_objectArrayWithKeyValuesArray:downDic[@"data"]];
    }
    _downNum = _modelArray.count;
    
    [_myTableView reloadData];
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
-(void)downloadDataFailed{
    //    失败
    ZZQLog(@"data Failed");
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}

#pragma mark
#pragma mark =========== 刷新
-(void)refrush{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initForData)];
    _myTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(initForNewData)];
    footer.refreshingTitleHidden = YES;
    //    footer.automaticallyHidden = YES;
    _myTableView.mj_footer = footer;
    
}

#pragma mark
#pragma mark ============ 返回到顶部
-(void)initForReturnTopView{
    _topButton = [MyBackTopButton backButton];
    _topButton.frame = CGRectMake(self.view.width-50, self.view.height*0.8, 40, 40);
    _topButton.layer.cornerRadius = 20;
    [_topButton addTarget:self action:@selector(returnTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topButton];
}
-(void)returnTop{
    [self.myTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [_topButton removeFromSuperview];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > self.view.height*.07) {
        if (_topButton != nil) {
            [_topButton removeFromSuperview];
        }
        [self initForReturnTopView];
    }else if(scrollView.contentOffset.y < self.view.height*.07){
        [_topButton removeFromSuperview];
    }
}
#pragma mark
#pragma mark ============ 创建shitu
-(void)initForView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    _bakeCell = [tableView dequeueReusableCellWithIdentifier:@"bakecell"];
    _niuCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        _niuCell = [[NiuTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        if (indexPath.row < 2) {
            [_niuCell setUpModel:_niuModelArray[indexPath.row]];
        }else{
            [_niuCell setUpArray:_niuArray index:indexs];
            __block NSArray * typeArray = @[@"getDish",@"getRecipe",@"getVideo", @"getTalent",@"getTest", @"getSchool"];
            __weak typeof(self) mySelf = self;
            [_niuCell setChangeTypeBlock:^(NSInteger index) {
                _seletType = typeArray[index];
                indexs = index;
                _downUrlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/%@", _typeStr, _seletType];
                [mySelf initForData];
            }];
        }
        _niuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _niuCell;
    }else{
        if (_bakeCell == nil) {
            _bakeCell = [[BakeWayTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bakecell"];
        }
        for (UIView * view in _bakeCell.subviews) {
            [view removeFromSuperview];
        }
        [_bakeCell setCellStyle:_modelArray[indexPath.row]];
        _bakeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _bakeCell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 95;
    }else{
        //    topmargin:10 用户头像高:40 用户介绍:动态变化 底边:10 图片高度
        //    描述高度
        float leftMargin = self.view.width-70;
        float desHeight = [self labelHeight:indexPath];
        if (desHeight > 34) {
            desHeight = 34;
        }
        //    图片高度
        float showPicWidth = (leftMargin-30-2*3)/3;
        NSInteger count = 0;
        count = _modelArray[indexPath.row].image.count;
        NSInteger row = 0;
        if (count <= 3) {
            row = 1;
        }else if(count <= 6){
            row = 2;
        }else{
            row = 3;
        }
        float showPicAllWidth = row * (showPicWidth+3);
        if ((_modelArray[indexPath.row].image.count == 1) || (_modelArray[indexPath.row].image.count == 1)) {
            showPicAllWidth = 2*(showPicWidth+3);
        }
        //    点赞区域 30
        //    评论区
        Comment_bakeWay * commnt = nil;
        commnt = _modelArray[indexPath.row].comment;
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
}
-(CGFloat)labelHeight:(NSIndexPath *)indexPath{
    CGSize mySize = CGSizeMake(self.view.width-70, CGFLOAT_MAX);
    CGSize size = [_modelArray[indexPath.row].introduce boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}
//计算评论高度
-(CGFloat)commentHeight:(NSString *)text{
    CGSize mySize = CGSizeMake(self.view.width-70-30, CGFLOAT_MAX);
    CGSize size = [text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}
//headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView * view = [[UIView alloc] init];
        _segmentView = [[UISegmentedControl alloc] initWithItems:@[@"最新", @"最热"]];
        float segWidth = self.view.width/4;
        _segmentView.frame = CGRectMake(segWidth*1.5, 0, segWidth, 30);
        _segmentView.tintColor = [UIColor whiteColor];
        _segmentView.backgroundColor = [UIColor grayColor];
        _segmentView.selectedSegmentIndex = seleNume;
        _segmentView.layer.cornerRadius = 15;
        _segmentView.clipsToBounds = YES;
        [_segmentView addTarget:self action:@selector(changeHotOrNow) forControlEvents:UIControlEventValueChanged];
        [view addSubview:_segmentView];
        return view;
    }else
        return nil;
}
-(void)changeHotOrNow{
    seleNume = _segmentView.selectedSegmentIndex;
    if (_segmentView.selectedSegmentIndex == 0) {
        _downParamsDic[@"sort"] = @"new";
    }else{
        _downParamsDic[@"sort"] = @"hot";
    }
    [self initForData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }else{
        return 0.1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
