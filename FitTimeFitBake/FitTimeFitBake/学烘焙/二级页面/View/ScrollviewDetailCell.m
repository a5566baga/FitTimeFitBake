//
//  ScrollviewDetailCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ScrollviewDetailCell.h"
#import <UIImageView+WebCache.h>

#define LEFT_MARGIN 30
#define TOP_MARGIN 10

@interface ScrollviewDetailCell ()

@property(nonatomic, strong)StepModel * myModel;
@property(nonatomic, assign)NSInteger stepNum;

@property(nonatomic, strong)UILabel * stepLabel;
@property(nonatomic, strong)UIImageView * stepPic;
@property(nonatomic, strong)UILabel * stepDetailLabel;

@end

@implementation ScrollviewDetailCell

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForCellView];
}

#pragma mark
#pragma mark ========= 主界面的搭建
-(void)initForCellView{
    _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, TOP_MARGIN, LEFT_MARGIN, LEFT_MARGIN)];
    _stepLabel.text = [NSString stringWithFormat:@"%ld", _stepNum];
    _stepLabel.font = [UIFont systemFontOfSize:20];
    _stepLabel.textAlignment = NSTextAlignmentCenter;
    _stepLabel.textColor = [UIColor blackColor];
    [self addSubview:_stepLabel];
    
    float picWidth = self.width*0.6;
    _stepPic = [[UIImageView alloc] initWithFrame:CGRectMake(2*LEFT_MARGIN, TOP_MARGIN, picWidth, picWidth/7*5)];
    [_stepPic sd_setImageWithURL:[NSURL URLWithString:_myModel.image] placeholderImage:[UIImage imageNamed:@"gray_bg"]];
    _stepPic.userInteractionEnabled = YES;
    [self addSubview:_stepPic];
    
    float detailHeight = [self labelHeight:[UIFont systemFontOfSize:13] text:_myModel.text width:self.width-LEFT_MARGIN-10-20];
    _stepDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*LEFT_MARGIN, CGRectGetMaxY(_stepPic.frame)+10, self.width-2*LEFT_MARGIN-20, detailHeight)];
    _stepDetailLabel.font = [UIFont systemFontOfSize:13];
    _stepDetailLabel.textColor = [UIColor grayColor];
    _stepDetailLabel.textAlignment = NSTextAlignmentLeft;
    _stepDetailLabel.text = _myModel.text;
    _stepDetailLabel.numberOfLines = 0;
    [self addSubview:_stepDetailLabel];
}

#pragma mark
#pragma mark ======== 设置model
-(void)setCellStyle:(StepModel *)model index:(NSInteger)index{
    _myModel = model;
    _stepNum = index;
}

-(CGFloat)labelHeight:(UIFont *)font text:(NSString *)text width:(float)width{
    CGSize mySize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}
@end
