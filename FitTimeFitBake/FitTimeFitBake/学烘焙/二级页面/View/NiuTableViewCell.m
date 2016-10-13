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
//类型的cell

//下面的样式

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
    
//    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
}
-(void)initForUpCellTypeView{
    
}

#pragma mark
#pragma mark =========== 为cell赋值
-(void)setUpModel:(NiuModel*)upModels{
    _niuModel = upModels;
}
-(void)setUpArray:(NSArray *)titleArray{
    _typeArray = titleArray;
}
-(void)setDownModel:(BakeWayModel *)downModel{
    _downModel = downModel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
