//
//  BakeWayHeaderView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BakeWayHeaderView.h"
#import <UIImageView+WebCache.h>

#define PIC_HEIGHT self.width/8*3

@interface BakeWayHeaderView ()<UIScrollViewDelegate>

//轮播图
@property(nonatomic, strong)UIScrollView * myScrollView;
@property(nonatomic, strong)UIImageView * picView;
@property(nonatomic, strong)UIPageControl * myPageControl;
@property(nonatomic, strong)NSArray * picArray;
@property(nonatomic, strong)NSTimer * myTimer;
//下面的分类
@property(nonatomic, strong)UIButton * theNewButton;
@property(nonatomic, strong)UIButton * theHotButton;
@property(nonatomic, strong)UIButton * theFollowButton;
@property(nonatomic, strong)UIView * downLineView;

@end

@implementation BakeWayHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setPicArray:(NSArray *)picArrays{
    _picArray = picArrays;
}

-(void)layoutSubviews{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [super layoutSubviews];
    [self initForView];
    [self initForSegment];
    [self initForPageControl];
    [self initForTimer];
}

#pragma mark
#pragma mark ========= 创建scrollview 和图片
-(void)initForView{
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, PIC_HEIGHT)];
    _myScrollView.bounces = NO;
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    [self addSubview:_myScrollView];
    _myScrollView.delegate = self;
    _myScrollView.contentSize = CGSizeMake(self.width*_picArray.count, 0);
    _myScrollView.contentOffset = CGPointMake(self.width, 0);
    
    for (NSInteger i = 0; i < _picArray.count; i++) {
        _picView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*i, 0, self.width, PIC_HEIGHT)];
        _picView.userInteractionEnabled = YES;
        [_picView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]] placeholderImage:[UIImage imageNamed:@"china"]];
        [self.myScrollView addSubview:_picView];
    }
}

#pragma mark
#pragma mark ========= 创建指示器
-(void)initForPageControl{
    _myPageControl = [[UIPageControl alloc] init];
    _myPageControl.frame = CGRectMake(self.width-60, PIC_HEIGHT-20, 50, 10);
    _myPageControl.numberOfPages = _picArray.count-2;
    _myPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _myPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_myPageControl];
}

#pragma mark
#pragma mark ========== 创建计时器
-(void)initForTimer{
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changPic) userInfo:nil repeats:YES];
}
-(void)changPic{
    NSInteger index = _myScrollView.contentOffset.x/self.width;
    if (index < _picArray.count-1) {
        index += 1;
    }
    if (index == 0) {
        _myPageControl.currentPage = _picArray.count-2;
        [_myScrollView setContentOffset:CGPointMake(self.width*(_picArray.count-2), 0) animated:YES];
    }else if (index == _picArray.count-1){
        _myPageControl.currentPage = 0;
        [_myScrollView setContentOffset:CGPointMake(self.width, 0) animated:YES];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _myPageControl.currentPage = index-1;
            [_myScrollView setContentOffset:CGPointMake(self.width*index, 0) animated:YES];
//            _myScrollView.contentOffset = CGPointMake(self.width*index, 0);
        }];
    }
}

#pragma mark
#pragma mark =========== 创建分类
-(void)initForSegment{
    float btnWidth = self.width/3;
    _theNewButton = [[UIButton alloc] init];
    _theNewButton.frame = CGRectMake(0, PIC_HEIGHT, btnWidth, self.height-PIC_HEIGHT);
    _theNewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_theNewButton setBackgroundColor:[UIColor whiteColor]];
    [_theNewButton setTitle:@"最新" forState:UIControlStateNormal];
    [_theNewButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_theNewButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_theNewButton addTarget:self action:@selector(theNewAction:) forControlEvents:UIControlEventTouchUpInside];
    _theNewButton.selected = YES;
    [self addSubview:_theNewButton];
    
    _theHotButton = [[UIButton alloc] init];
    _theHotButton.frame = CGRectMake(btnWidth, PIC_HEIGHT, btnWidth, self.height-PIC_HEIGHT);
    _theHotButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_theHotButton setBackgroundColor:[UIColor whiteColor]];
    [_theHotButton setTitle:@"最热" forState:UIControlStateNormal];
    [_theHotButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_theHotButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_theHotButton addTarget:self action:@selector(theHotAction:) forControlEvents:UIControlEventTouchUpInside];
    _theHotButton.selected = YES;
    [self addSubview:_theHotButton];
    _theHotButton.selected = NO;
    
    _theFollowButton = [[UIButton alloc] init];
    _theFollowButton.frame = CGRectMake(btnWidth*2, PIC_HEIGHT, btnWidth, self.height-PIC_HEIGHT);
    _theFollowButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_theFollowButton setBackgroundColor:[UIColor whiteColor]];
    [_theFollowButton setTitle:@"关注" forState:UIControlStateNormal];
    [_theFollowButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_theFollowButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_theFollowButton addTarget:self action:@selector(theFollowAction:) forControlEvents:UIControlEventTouchUpInside];
    _theFollowButton.selected = YES;
    [self addSubview:_theFollowButton];
    _theFollowButton.selected = NO;
    
    _downLineView = [[UIImageView alloc] init];
    _downLineView.frame = CGRectMake(0, self.height-2, btnWidth, 2);
    _downLineView.backgroundColor = [UIColor redColor];
    [self addSubview:_downLineView];
}
#warning 没有将选择的状态回调
-(void)theNewAction:(UIButton *)btn{
    if (_theNewButton.selected == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            _theNewButton.selected = !_theNewButton.selected;
            _theFollowButton.selected = NO;
            _theHotButton.selected = NO;
            _downLineView.x = btn.x;
        }];
    }
}
-(void)theHotAction:(UIButton *)btn{
    if (_theHotButton.selected == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            _theNewButton.selected = NO;
            _theFollowButton.selected = NO;
            _theHotButton.selected = !_theHotButton.selected;
            _downLineView.x = btn.x;
        }];
    }
}
-(void)theFollowAction:(UIButton *)btn{
    if (_theFollowButton.selected == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            _theNewButton.selected = NO;
            _theFollowButton.selected = !_theFollowButton.selected;
            _theHotButton.selected = NO;
            _downLineView.x = btn.x;
        }];
    }
}

#pragma mark
#pragma mark ========= 代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.width;
    if (index == 0) {
        _myPageControl.currentPage = _picArray.count-2;
        _myScrollView.contentOffset  = CGPointMake(self.width*(_picArray.count-2), 0);
    }else if (index == _picArray.count-1){
        _myPageControl.currentPage = 0;
        _myScrollView.contentOffset = CGPointMake(self.width, 0);
    }else{
        _myPageControl.currentPage = index-1;
        _myScrollView.contentOffset = CGPointMake(self.width*index, 0);
    }
}
@end
