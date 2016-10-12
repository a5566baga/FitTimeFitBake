//
//  PinShoppingViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/30.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "PinShoppingViewController.h"
#import "PinTuanTableViewCell.h"
#import "PinView.h"

@interface PinShoppingViewController ()<NetDataDownLoadDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSString * myTypeStr;
@property(nonatomic, copy)NSString * myIdStr;
//url
@property(nonatomic, copy)NSString * urlStr;
@property(nonatomic, strong)NSDictionary * paramDic;
//数据
@property(nonatomic, strong)NetDataDownLoad * dataDown;
@property(nonatomic, strong)NSDictionary * dataDic;
@property(nonatomic, copy)NSString * picStr;
@property(nonatomic, copy)NSString * titleStr;
@property(nonatomic, copy)NSString * nowPrice;
@property(nonatomic, copy)NSString * originPrice;
@property(nonatomic, copy)NSString * htmlStr;
//tableView
@property(nonatomic, strong)UITableView * tableView;



@end

@implementation PinShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForData];
}

#pragma mark
#pragma mark =========== 请求数据
-(void)initForData{
    _urlStr = [NSString stringWithFormat:@"http://api.hongbeibang.com/%@/get", _myTypeStr];
    _paramDic = @{@"contentId":_myIdStr};
    _dataDown = [[NetDataDownLoad alloc] init];
    _dataDown.delegate = self;
    [_dataDown GET:_urlStr params:_paramDic];
}
-(void)downloadDataFinshed{
    _dataDic = _dataDown.dataDic[@"data"];
    _picStr = _dataDic[@"coverImage"];
    _titleStr = _dataDic[@"coverTitle"];
    _nowPrice = _dataDic[@"payPrice"];
    _originPrice= _dataDic[@"originPrice"];
    _htmlStr = _dataDic[@"description"];
    
    [self initForView];
}
-(void)downloadDataFailed{
#warning 错误页面
    ZZQLog(@"下载失败");
}
#pragma mark
#pragma mark ========== 创建页面
-(void)initForView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PinTuanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[PinTuanTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellValue:_htmlStr];
    [cell setScrollToTop:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentOffset = CGPointMake(0, 0);
        }];
    }];
    [cell setScrollToDown:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentOffset = CGPointMake(0, self.view.width/9*6+15+10*6);
        }];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = self.view.height-64-35;
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PinView * pinView = [[PinView alloc] init];
    pinView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [pinView setValueForHeader:_picStr title:_titleStr nowPrice:_nowPrice originPrice:_originPrice];
    return pinView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    float height = self.view.width/9*6;
    height += 15+10*6;
    return height;
}
#pragma mark
#pragma mark =========== 获得对应参数
-(void)setNetWorkParams:(NSString *)typeStr idStr:(NSString *)idStr{
    _myTypeStr = typeStr;
    _myIdStr = idStr;
}

#pragma mark
#pragma mark ============ 基本页面的设置
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
    
}

@end
