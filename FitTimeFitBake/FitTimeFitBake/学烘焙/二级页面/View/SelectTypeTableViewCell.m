//
//  SelectTypeTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/11.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SelectTypeTableViewCell.h"
#import <UIImageView+WebCache.h>

#define LEFT_MARGIN 20
#define TOP_MARGIN 10
@interface SelectTypeTableViewCell ()

@property(nonatomic, strong)SelectTypeModel * model;
@property(nonatomic, strong)UIImageView * picView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * usernameLabel;
@property(nonatomic, strong)UILabel * stepLabel;
@property(nonatomic, strong)UILabel * bottomLabel;
@property(nonatomic, strong)UIView * lineView;

@end

@implementation SelectTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellModel:(SelectTypeModel *)model{
    _model = model;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForCellView];
}

#pragma mark
#pragma mark ============= 设置cell
-(void)initForCellView{
    _picView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, TOP_MARGIN, 100, 90)];
    _picView.userInteractionEnabled = YES;
    [_picView sd_setImageWithURL:[NSURL URLWithString:_model.coverImage] placeholderImage:[UIImage imageNamed:@"gray_bg"]];
    [self addSubview:_picView];
    
    float labelWidth = self.width-2*LEFT_MARGIN-TOP_MARGIN;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_picView.frame)+TOP_MARGIN, TOP_MARGIN, labelWidth, 20)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = _model.title;
    [self addSubview:_titleLabel];
    
    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame)+5, labelWidth, 15)];
    _usernameLabel.textAlignment = NSTextAlignmentLeft;
    _usernameLabel.textColor = [UIColor grayColor];
    _usernameLabel.font = [UIFont systemFontOfSize:14];
    _usernameLabel.text = _model.clientName;
    [self addSubview:_usernameLabel];
    
    _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_usernameLabel.frame)+5, labelWidth, 15)];
    _stepLabel.textAlignment = NSTextAlignmentLeft;
    _stepLabel.textColor = [UIColor blackColor];
    _stepLabel.font = [UIFont systemFontOfSize:14];
    _stepLabel.text = [NSString stringWithFormat:@"%ld个步骤", _model.step.count];
    [self addSubview:_stepLabel];
    
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_stepLabel.frame)+10, labelWidth, 15)];
    _bottomLabel.textAlignment = NSTextAlignmentLeft;
    _bottomLabel.textColor = [UIColor grayColor];
    _bottomLabel.font = [UIFont systemFontOfSize:13];
    _bottomLabel.text = [NSString stringWithFormat:@"%ld次浏览 %ld人收藏 %ld做", _model.visitNum, _model.collectNum, _model.dishNum];
    [self addSubview:_bottomLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [self addSubview:_lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
