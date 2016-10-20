//
//  NiuTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "NiuTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import "MyZanButton.h"

#define UP_TOP_MARGIN 10
#define LEFT_MARGIN 15
@interface NiuTableViewCell ()

@property(nonatomic, strong)NiuModel * niuModel;
@property(nonatomic, strong)NSArray * typeArray;
@property(nonatomic, strong)BakeWayModel * downModel;
//上面的样式
@property(nonatomic, strong)UIImageView * picView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * detailLabel;
@property(nonatomic, strong)UIImageView * goPicView;
@property(nonatomic, strong)UIView * downLine;
@property(nonatomic, assign)NSInteger selNum;
//类型的cell
@property(nonatomic, strong)UIButton * typeButton;

@end

@implementation NiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    if (_niuModel != nil) {
        [self initForUpCell];
    }
    if (_typeArray.count != 0) {
        [self initForUpCellTypeView];
    }
    if (_downModel != nil) {
        
    }
}
#pragma mark
#pragma mark ========== 上面的cell样式
-(void)initForUpCell{
    _picView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, UP_TOP_MARGIN, 70, 70)];
    [_picView sd_setImageWithURL:[NSURL URLWithString:_niuModel.coverImage] placeholderImage:[UIImage imageNamed:@"gray_bg"]];
    [self addSubview:_picView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_picView.frame)+LEFT_MARGIN, UP_TOP_MARGIN, self.width-CGRectGetMaxX(_picView.frame)-2*LEFT_MARGIN, 20)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.text = _niuModel.title;
    [self addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_picView.frame)+LEFT_MARGIN, CGRectGetMaxY(_titleLabel.frame), self.width-CGRectGetMaxX(_picView.frame)-2*LEFT_MARGIN, _picView.height-20)];
    _detailLabel.numberOfLines = 0;
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = [UIColor grayColor];
    _detailLabel.text = _niuModel.coverSummary;
    [self addSubview:_detailLabel];
    
    _downLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-5, self.width, 5)];
    _downLine.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [self addSubview:_downLine];
}
-(void)initForUpCellTypeView{
    self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    float btnWidth = (self.width-2*3)/3;
    float btnHeight = btnWidth*0.3;
    for (NSInteger i = 0; i < _typeArray.count; i++) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _typeButton.frame = CGRectMake(0+(btnWidth+2)*(i%3), (self.height-2*btnWidth*0.3-4)/2+(btnHeight+2)*(i/3), btnWidth, btnHeight);
        _typeButton.backgroundColor = [UIColor whiteColor];
        [_typeButton setTitle:_typeArray[i] forState:UIControlStateNormal];
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_typeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_typeButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (_selNum == i) {
            _typeButton.selected = YES;
        }
        _typeButton.tag = 200+i;
        [_typeButton addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_typeButton];
    }
}
-(void)changeType:(UIButton *)btn{
#warning 重新添加参数，更新内容
    for (UIButton * bttn in self.subviews) {
        bttn.selected = NO;
    }
    btn.selected = YES;
    NSInteger index = btn.tag%10;
    self.changeTypeBlock(index);
}

#pragma mark
#pragma mark =========== 为cell赋值
-(void)setUpModel:(NiuModel*)upModels{
    _niuModel = upModels;
}
-(void)setUpArray:(NSArray *)titleArray index:(NSInteger)index{
    _typeArray = titleArray;
    _selNum = index;
}
-(void)setDownModel:(BakeWayModel *)downModel{
    _downModel = downModel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
