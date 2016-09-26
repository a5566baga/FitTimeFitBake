//
//  BakeWayHeaderView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BakeWayHeaderView.h"
#import <UIImageView+WebCache.h>

@interface BakeWayHeaderView ()

//轮播图
@property(nonatomic, strong)UIScrollView * myScrollView;
@property(nonatomic, strong)UIPageControl * myPageControl;
@property(nonatomic, strong)NSMutableArray * picArray;
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
        [self initForData];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self initForView];
    [self initForSegment];
    [self initForPageControl];
    [self initForTimer];
}

#pragma mark
#pragma mark ========== 请求数据
-(void)initForData{
    
}

#pragma mark
#pragma mark ========= 创建scrollview 和图片
-(void)initForView{
    
}

#pragma mark
#pragma mark ========= 创建指示器
-(void)initForPageControl{
    
}

#pragma mark
#pragma mark ========== 创建计时器
-(void)initForTimer{
    
}

#pragma mark
#pragma mark =========== 创建分类
-(void)initForSegment{
    
}

#pragma mark
#pragma mark ========= 代理方法

@end
