//
//  LearnBakeTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/21.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "LearnBakeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import <UIImage+GIF.h>
#import "MyFoundButton.h"
#import "MyHotButton.h"
#import "MyDayActityButton.h"
#import "MyBigClassButton.h"

#define topMargin 20
#define margin 10
#define titleMargin 15

@interface LearnBakeTableViewCell ()<UIScrollViewDelegate>

@property(nonatomic, strong)LearnBakeModel * model;
//轮播图
@property(nonatomic, strong)UIPageControl * pageControl;
@property(nonatomic, strong)UIScrollView * scrollView;
@property(nonatomic, strong)UIImageView * picImageView;
@property(nonatomic, strong)UIView * bgView;
@property(nonatomic, strong)UILabel * titlesLabel;
@property(nonatomic, strong)NSMutableArray * picArray;
@property(nonatomic, strong)NSMutableArray * titleArray;
@property(nonatomic, strong)NSTimer * timer;
@property(nonatomic, strong)UITapGestureRecognizer * tap;
//分类食谱
@property(nonatomic, strong)UIImageView * leftView;
@property(nonatomic, strong)UILabel * classifyTitleLabel;
@property(nonatomic, strong)UIButton * classifyButton;
@property(nonatomic, strong)UIButton * checkAllButton;
//拼团
@property(nonatomic, strong)UIScrollView * pinTuanBgView;
@property(nonatomic, strong)UIView * productBgView;
@property(nonatomic, strong)UIImageView * productPic;
@property(nonatomic, strong)UIImageView * successPinPic;
@property(nonatomic, strong)UILabel * numOfPerpleLabel;
@property(nonatomic, strong)UIButton * goTuanButton;
@property(nonatomic, strong)UITapGestureRecognizer * tuanTap;

@property(nonatomic, strong)NSTimer * jishiTimer;
@property(nonatomic, strong)UILabel * hourLabel;
@property(nonatomic, strong)UILabel * minLabel;
@property(nonatomic, strong)UILabel * secondLabel;
@property(nonatomic, strong)UILabel * noStartLabel;

//精选菜单
@property(nonatomic, strong)UIButton * goMenuButton;
@property(nonatomic, strong)UIImageView * menuPic;
//发现
@property(nonatomic, strong)MyFoundButton * foundButton;
//热门
@property(nonatomic, strong)MyHotButton * hotButton;
//食谱达人
@property(nonatomic, strong)UIButton * goMenuGoodButton;
@property(nonatomic, strong)UIScrollView * menuGoodScrollView;
@property(nonatomic, strong)UIButton * menuGoodButton;
//日常活动
@property(nonatomic, strong)UIButton * goDayActivtyButton;
@property(nonatomic, strong)MyDayActityButton * dayActityButton;
//大课堂
@property(nonatomic, strong)UIButton * goBigClassButton;
@property(nonatomic, strong)MyBigClassButton * bigClassButton;
//友情链接
@property(nonatomic, strong)UIButton * linkButton;
//牛气部落
@property(nonatomic, strong)UIImageView * niuPicView;

@end

@implementation LearnBakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//每个Cell的title内容的封装
-(void)initForTitleView{
    _leftView = [[UIImageView alloc] init];
    _leftView.frame = CGRectMake(margin, topMargin, 3, titleMargin);
    _leftView.backgroundColor = [UIColor redColor];
    [self addSubview:_leftView];
    _classifyTitleLabel = [[UILabel alloc] init];
    _classifyTitleLabel.frame = CGRectMake(2*margin, topMargin, 100, titleMargin);
    _classifyTitleLabel.textColor = [UIColor blackColor];
    _classifyTitleLabel.text = _model.title;
    _classifyTitleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_classifyTitleLabel];
}

#pragma mark
#pragma mark ========= 轮播图
-(void)initForScrollView{
    //    解析数据
    NSArray<Item_Bake *> * array = _model.item;
    _picArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    for (Item_Bake * item in array) {
        [_picArray addObject:[item image]];
        [_titleArray addObject:[item title]];
    }
    NSArray * tempPic = [NSArray arrayWithArray:_picArray];
    [_picArray addObject:tempPic.firstObject];
    [_picArray insertObject:tempPic.lastObject atIndex:0];
    NSArray * tempTitle = [NSArray arrayWithArray:_titleArray];
    [_titleArray addObject:tempTitle.firstObject];
    [_titleArray insertObject:tempTitle.lastObject atIndex:0];
    //    创建scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.width*(_picArray.count-1), self.height);
    //    创建图片
    for (NSInteger i = 0; i < _picArray.count; i++) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*i, 0, self.width, self.height)];
        //        _picImageView.userInteractionEnabled = YES;
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]] placeholderImage:[UIImage imageNamed:@"china"]];
        [self.scrollView addSubview:_picImageView];
    }
    _scrollView.contentOffset = CGPointMake(self.width, 0);
    //    创建底部的黑色背景
    _bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(0, self.height-30, self.width, 30);
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.8;
    [self addSubview:_bgView];
    //    创建指示器
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake((self.width)/3*2, 0, (self.width-20)/4, 30);
    _pageControl.userInteractionEnabled = NO;
    _pageControl.numberOfPages = tempPic.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.bgView addSubview:_pageControl];
    //    创建label
    _titlesLabel = [[UILabel alloc] init];
    _titlesLabel.frame = CGRectMake(10, 0, (self.width-20)/3*2, 30);
    _titlesLabel.textColor = [UIColor whiteColor];
    _titlesLabel.font = [UIFont systemFontOfSize:12];
    _titlesLabel.textAlignment = NSTextAlignmentLeft;
    _titlesLabel.backgroundColor = [UIColor clearColor];
    _titlesLabel.text = _titleArray[1];
    [self.bgView addSubview:_titlesLabel];
    
    [self initForTimer];
    
//    创建点击手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPic:)];
    _tap.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:_tap];
}
//tap事件
-(void)tapPic:(UITapGestureRecognizer *)tap{
    UIScrollView * nowScrollView = (UIScrollView *)tap.view;
    NSInteger index = nowScrollView.contentOffset.x/self.width;
    ScrollViewDetailViewController * scorllViewVC = [[ScrollViewDetailViewController alloc] init];
    NSArray * parmasArray = [self getParams:index];
    self.goToPicDetail(scorllViewVC, parmasArray[0], parmasArray[1]);
}
#pragma mark
#pragma mark ========== 定时器
-(void)initForTimer{
    _timer  = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runPic) userInfo:nil repeats:YES];
}
-(void)runPic{
    float  _X = self.scrollView.contentOffset.x+self.width;
    
    [self.scrollView setContentOffset:CGPointMake(_X, 0) animated:YES];
}
#pragma mark
#pragma mark ============ scrollView的代理(轮播处理)
-(void)movePicture{
    if (_scrollView.contentOffset.x/self.width == 0) {
        _scrollView.contentOffset = CGPointMake(self.width*(_titleArray.count-2), 0) ;
    }else if (_scrollView.contentOffset.x/self.width == _titleArray.count+1-2){
        _scrollView.contentOffset = CGPointMake(self.width, 0);
    }
    NSInteger index = _scrollView.contentOffset.x/self.width-1;
    _pageControl.currentPage = index;
    _titlesLabel.text = _titleArray[index];
}

//开始减速，这里调用移动的方法
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self movePicture];
}
//减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self movePicture];
    
}
//动画结束，
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self movePicture];
}

#pragma mark
#pragma mark =========== 分类食谱
-(void)initForClassifyFood{
    NSArray * buttonArray = _model.item;
    for (NSInteger i = 0; i < buttonArray.count; i++) {
        float width = (self.width-4*10)/3;
        float height = 30;
        _classifyButton = [[UIButton alloc] init];
        _classifyButton.frame = CGRectMake(10+(width+10)*(i%3), 2*topMargin+margin+(10+height)*(i/3), width, height);
        [_classifyButton setTitle:[buttonArray[i] title] forState:UIControlStateNormal];
        [_classifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_classifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _classifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _classifyButton.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00].CGColor;
        _classifyButton.layer.borderWidth = 1;
        _classifyButton.layer.cornerRadius = 5;
        _classifyButton.tag = 200+i;
        [_classifyButton addTarget:self action:@selector(classifyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_classifyButton];
    }
    _checkAllButton = [[UIButton alloc] init];
    _checkAllButton.frame = CGRectMake(margin, CGRectGetMaxY(_classifyButton.frame)+margin, self.width-2*margin, 35);
    [_checkAllButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_checkAllButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBgClick"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [_checkAllButton setTitle:@"查看全部分类" forState:UIControlStateNormal];
    [_checkAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _checkAllButton.layer.masksToBounds = YES;
    _checkAllButton.clipsToBounds = YES;
    _checkAllButton.layer.cornerRadius = 5;
    [_checkAllButton addTarget:self action:@selector(checkAllButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkAllButton];
}
#warning 分类食谱的事件处理
-(void)classifyButtonAction:(UIButton *)button{
    NSInteger index = button.tag - 200;
    NSArray * params = [self getParams:index];
    SelectTypeViewController * selectTypeVC = [[SelectTypeViewController alloc] init];
    self.goToSelectTypeDetail(selectTypeVC, params[0], params[0]);
}
-(void)checkAllButton:(UIButton *)button{
#warning 单独处理
    AllTypeViewController * allTypeVC = [[AllTypeViewController alloc] init];
    self.goToFoodTypeDetail(allTypeVC, @"classify", @"get");
}
#pragma mark
#pragma mark ======== 拼团
-(void)initForPinTuanView{
    _goTuanButton = [[UIButton alloc] init];
    _goTuanButton.frame = CGRectMake(self.width-25, topMargin, 15, 10);
    [_goTuanButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateNormal];
    [_goTuanButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateHighlighted];
    [_goMenuButton addTarget:self action:@selector(goTuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goTuanButton];
    //    scrollview
    _pinTuanBgView = [[UIScrollView alloc] init];
    _pinTuanBgView.frame = CGRectMake(0, 2*topMargin+margin, self.width, self.height-(2*topMargin+margin));
    _pinTuanBgView.showsVerticalScrollIndicator = NO;
    _pinTuanBgView.showsHorizontalScrollIndicator = NO;
    _pinTuanBgView.bounces = NO;
    [self addSubview:_pinTuanBgView];
    //    拼团的内容
    NSArray<Item_Bake *> * tuanArray = _model.item;
    float width = 130;
    float height = 130;
    float bgHeight = 150;
    float bordMargin  =3;
    for (NSInteger i = 0; i < tuanArray.count; i++) {
#warning view上添加点击事件可以跳转二级页面
        //        图片的背景view
        _productBgView = [[UIView alloc] init];
        _productBgView.frame = CGRectMake(bordMargin+(width+bordMargin)*i, 0, width, bgHeight);
        _productBgView.layer.borderColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00].CGColor;
        _productBgView.layer.borderWidth = 0.5;
        [self.pinTuanBgView addSubview:_productBgView];
        _productPic = [[UIImageView alloc] init];
        _productPic.frame = CGRectMake(0, 0, width, height);
        _productPic.userInteractionEnabled = YES;
        [_productPic sd_setImageWithURL:[NSURL URLWithString:[tuanArray[i] image]]];
        [_productBgView addSubview:_productPic];
        if ([tuanArray[i] isSuccessGroupBuy]) {
            _successPinPic = [[UIImageView alloc] init];
            _successPinPic.frame = CGRectMake(width-30-margin, height-50, 30, 30);
            _successPinPic.image = [UIImage imageNamed:@"successPinTuan"];
            [self.productBgView addSubview:_successPinPic];
        }
        _numOfPerpleLabel = [[UILabel alloc] init];
        _numOfPerpleLabel.frame = CGRectMake(0, height-10, width, 15);
        _numOfPerpleLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.00];
        _numOfPerpleLabel.font = [UIFont systemFontOfSize:12];
        _numOfPerpleLabel.textAlignment = NSTextAlignmentCenter;
        _numOfPerpleLabel.text = [NSString stringWithFormat:@"%ld人拼团", [tuanArray[i] groupNum]];
        [self.productBgView addSubview:_numOfPerpleLabel];
        _tuanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTuanAction:)];
        _tuanTap.numberOfTapsRequired = 1;
        [self.productBgView addGestureRecognizer:_tuanTap];
#warning 添加定时器，准备倒计时
        
    }
    _pinTuanBgView.contentSize = CGSizeMake((bordMargin + width)*tuanArray.count, 0);
}
//显示倒计时的时间
-(void)initDateForShop{
    
}
-(void)goTuanAction:(UIButton *)btn{
    self.goToTuanVC();
}
-(void)tapTuanAction:(UITapGestureRecognizer *)tap{
    UIScrollView * tuanView = (UIScrollView *)tap.view;
    NSInteger index = tuanView.contentOffset.x/133;
    NSArray * params = [self getParams:index];
    PinShoppingViewController * pinVC = [[PinShoppingViewController alloc] init];
    self.goToPinShoppingDetail(pinVC, params[0], params[1]);
}
#pragma mark
#pragma mark ========= 精选菜单
-(void)initForChooseMenu{
#warning 没有添加事件
    _goMenuButton = [[UIButton alloc] init];
    _goMenuButton.frame = CGRectMake(self.width-25, topMargin, 15, 10);
    [_goMenuButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateNormal];
    [_goMenuButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateHighlighted];
    [self addSubview:_goMenuButton];
    _menuPic = [[UIImageView alloc] init];
    _menuPic.userInteractionEnabled = YES;
    _menuPic.frame = CGRectMake(margin, 2*topMargin+margin, self.width-2*margin, self.width/2.5);
    _menuPic.layer.cornerRadius = 10;
    _menuPic.clipsToBounds = YES;
    [_menuPic sd_setImageWithURL:[NSURL URLWithString:[_model.item.firstObject image]]];
    [self addSubview:_menuPic];
}
#pragma mark
#pragma mark ========= 发现的cell样式
-(void)initForFoundView{
    NSArray<Item_Bake *> * foundArray = _model.item;
    float btnWidth = (self.width-margin*5)/foundArray.count;
    for (NSInteger i = 0 ; i < foundArray.count; i++) {
        _foundButton = [[MyFoundButton alloc] init];
        _foundButton.frame = CGRectMake(margin+(margin+btnWidth)*i, 2*topMargin+margin, btnWidth, btnWidth+20);
        [_foundButton sd_setImageWithURL:[NSURL URLWithString:[foundArray[i] image]] forState:UIControlStateNormal];
        [_foundButton sd_setImageWithURL:[NSURL URLWithString:[foundArray[i] image]] forState:UIControlStateHighlighted];
        [_foundButton setTitle:[foundArray[i] title] forState:UIControlStateNormal];
        _foundButton.tag = 300+i;
#warning 没有添加事件，根据tag值跳转
        [self addSubview:_foundButton];
    }
}
#pragma mark
#pragma mark ========== 热门榜单
-(void)initForHotView{
    NSArray<Item_Bake *> * hotArray = _model.item;
    for (NSInteger i = 0; i < hotArray.count; i++) {
        _hotButton = [[MyHotButton alloc] init];
        _hotButton.frame = CGRectMake(margin, 2*topMargin+margin+(50+margin)*i, self.width-margin, 50);
        [_hotButton sd_setImageWithURL:[NSURL URLWithString:[hotArray[i] image] ] forState:UIControlStateNormal];
        [_hotButton sd_setImageWithURL:[NSURL URLWithString:[hotArray[i] image] ] forState:UIControlStateHighlighted];
        [_hotButton setTitle:[hotArray[i] title] forState:UIControlStateNormal];
        [_hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotButton setDetailStr:[hotArray[i] introduce]];
        _hotButton.tag = 400+i;
#warning 通过tag得到button从而获得对应的url
        [self addSubview:_hotButton];
    }
}

#pragma mark
#pragma mark ========== 食谱达人
-(void)initForMenuGood{
    _goMenuGoodButton = [[UIButton alloc] init];
    _goMenuGoodButton.frame = CGRectMake(self.width-topMargin, topMargin, 15, 10);
    [_goMenuGoodButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateNormal];
    [_goMenuGoodButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateHighlighted];
#warning 没有添加事件
    [self addSubview:_goMenuGoodButton];
    
    float btnWidth = 50;
    NSArray<Item_Bake *> * menuGoodArray = _model.item;
    
    _menuGoodScrollView = [[UIScrollView alloc] init];
    _menuGoodScrollView.frame = CGRectMake(margin, 2*topMargin+margin, self.width, btnWidth);
    _menuGoodScrollView.showsVerticalScrollIndicator = NO;
    _menuGoodScrollView.showsHorizontalScrollIndicator = NO;
    _menuGoodScrollView.bounces = NO;
    _menuGoodScrollView.contentSize = CGSizeMake((btnWidth+margin)*menuGoodArray.count+margin, btnWidth);
    [self addSubview:_menuGoodScrollView];
    for (NSInteger i = 0; i < menuGoodArray.count; i++) {
        _menuGoodButton = [[UIButton alloc] init];
        _menuGoodButton.frame = CGRectMake((btnWidth+margin)*i, 0, btnWidth, btnWidth);
        [_menuGoodButton sd_setImageWithURL:[NSURL URLWithString:[menuGoodArray[i] image]] forState:UIControlStateNormal];
        _menuGoodButton.layer.cornerRadius = btnWidth/2;
        _menuGoodButton.clipsToBounds = YES;
        _menuGoodButton.tag = 500+i;
#warning 还没有添加事件
        [self.menuGoodScrollView addSubview:_menuGoodButton];
    }
}
#pragma mark
#pragma mark ========= 日常活动
-(void)initForDayActityView{
    _goDayActivtyButton = [[UIButton alloc] init];
    _goDayActivtyButton.frame = CGRectMake(self.width-topMargin, topMargin, 15, 10);
    [_goDayActivtyButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateNormal];
    [_goDayActivtyButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateHighlighted];
#warning 没有添加事件
    [self addSubview:_goDayActivtyButton];
    
    NSArray<Item_Bake *> * dayArray = _model.item;
    for (NSInteger i = 0; i < dayArray.count; i++) {
        _dayActityButton = [[MyDayActityButton alloc] init];
        _dayActityButton.frame = CGRectMake(margin, 2*topMargin+margin+30*i, self.width-2*margin, 20);
        [_dayActityButton setTitle:[dayArray[i] title] forState:UIControlStateNormal];
        [_dayActityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dayActityButton setNumPepleStr:@([dayArray[i] joinNum]).stringValue];
        if ([dayArray[i] flag]) {
            [_dayActityButton setGifNameStr:@"new"];
        }
#warning 没有添加事件
        [self addSubview:_dayActityButton];
    }
}
#pragma mark
#pragma mark ========= 大课堂
-(void)initForBigClassView{
    _goBigClassButton = [[UIButton alloc] init];
    _goBigClassButton.frame = CGRectMake(self.width-topMargin, topMargin, 15, 10);
    [_goBigClassButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateNormal];
    [_goBigClassButton setBackgroundImage:[UIImage imageNamed:@"right_arror"] forState:UIControlStateHighlighted];
#warning 没有添加事件
    [self addSubview:_goBigClassButton];
    
    NSArray<Item_Bake*> * bigClassArray = _model.item;
    for (NSInteger i = 0; i < bigClassArray.count; i++) {
        _bigClassButton = [[MyBigClassButton alloc] init];
        _bigClassButton.frame = CGRectMake(margin, 2*topMargin+margin+50*i, self.width-margin, 40);
        [_bigClassButton sd_setImageWithURL:[NSURL URLWithString:[bigClassArray[i] image]] forState:UIControlStateNormal];
        [_bigClassButton setTitle:[bigClassArray[i] title] forState:UIControlStateNormal];
        [_bigClassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_bigClassButton];
    }
}
#pragma mark
#pragma mark ========= 友情链接
-(void)initForLinkView{
    float width = (self.width-2*margin)/4;
    NSArray<Item_Bake *> * linkArray = _model.item;
    for (NSInteger i = 0; i < linkArray.count; i++) {
        _linkButton = [[UIButton alloc] init];
        _linkButton.frame = CGRectMake(margin+width*i, 2*topMargin, width, width);
        [_linkButton sd_setImageWithURL:[NSURL URLWithString:[linkArray[i] image]] forState:UIControlStateNormal];
        [_linkButton sd_setImageWithURL:[NSURL URLWithString:[linkArray[i] image]] forState:UIControlStateHighlighted];
        _linkButton.tag = 600+i;
#warning 没有添加事件
        [self addSubview:_linkButton];
    }
}
#pragma mark
#pragma mark =========== 神器部落
-(void)initForNiuView{
    _niuPicView = [[UIImageView alloc] init];
    _niuPicView.userInteractionEnabled = YES;
    _niuPicView.frame = CGRectMake(margin, 2*topMargin+margin, self.width-2*margin, self.width/2.5);
    _niuPicView.layer.cornerRadius = 10;
    _niuPicView.clipsToBounds = YES;
    [_niuPicView sd_setImageWithURL:[NSURL URLWithString:[_model.item.firstObject image]]];
    [self addSubview:_niuPicView];
}
#pragma mark
#pragma mark ========= 通过不同的类型创建不同的cell样式
//判断用哪种cell样式
-(void)layoutSubviews{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [super layoutSubviews];
    if ([_model.title isEqualToString:@"轮播图"]) {
        [self initForScrollView];
    }else if ([_model.title isEqualToString:@"分类食谱"]){
        [self initForTitleView];
        [self initForClassifyFood];
    }else if ([_model.title isEqualToString:@"拼团"]){
        [self initForTitleView];
        [self initForPinTuanView];
    }else if ([_model.title isEqualToString:@"精选菜单"]){
        [self initForTitleView];
        [self initForChooseMenu];
    }else if ([_model.title isEqualToString:@"发现"]){
        [self initForTitleView];
        [self initForFoundView];
    }else if ([_model.title isEqualToString:@"热门榜单"]){
        [self initForTitleView];
        [self initForHotView];
    }else if ([_model.title isEqualToString:@"食谱达人"]){
        [self initForTitleView];
        [self initForMenuGood];
    }else if ([_model.title isEqualToString:@"日常活动"]){
        [self initForTitleView];
        [self initForDayActityView];
    }else if ([_model.title isEqualToString:@"大课堂"]){
        [self initForTitleView];
        [self initForBigClassView];
    }else if ([_model.title isEqualToString:@"友情链接"]){
        [self initForTitleView];
        [self initForLinkView];
    }else{
        [self initForTitleView];
        [self initForNiuView];
    }
}
-(void)setCellStyle:(LearnBakeModel *)model{
    _model = model;
}

#pragma mark
#pragma mark =========== 工具类
-(NSArray *)getParams:(NSInteger)index{
    NSArray<Item_Bake *> * array = _model.item;
    NSString * linkStr = array[index].link;
    NSArray * strArray = [linkStr componentsSeparatedByString:@"/"];
    NSString * typeStr = strArray[strArray.count-2];
    NSString * idStr = [NSString stringWithFormat:@"%@", strArray.lastObject];
    NSArray * resultArray = @[typeStr, idStr];
    return resultArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
