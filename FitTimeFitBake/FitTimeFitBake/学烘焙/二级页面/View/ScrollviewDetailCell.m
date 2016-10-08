//
//  ScrollviewDetailCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ScrollviewDetailCell.h"

@interface ScrollviewDetailCell ()

@property(nonatomic, strong)StepModel * myModel;
@property(nonatomic, assign)NSInteger stepNum;

@end

@implementation ScrollviewDetailCell

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
}

#pragma mark
#pragma mark ======== 设置model
-(void)setCellStyle:(StepModel *)model index:(NSInteger)index{
    _myModel = model;
    _stepNum = index;
}

@end
