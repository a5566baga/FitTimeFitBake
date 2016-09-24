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

@property(nonatomic, strong)UIScrollView * myScrollView;
@property(nonatomic, strong)UIPageControl * myPageControl;
@property(nonatomic, strong)NSMutableArray * picArray;
@property(nonatomic, strong)NSTimer * myTimer;

@end

@implementation BakeWayHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
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
#pragma mark ========= 代理方法

@end
