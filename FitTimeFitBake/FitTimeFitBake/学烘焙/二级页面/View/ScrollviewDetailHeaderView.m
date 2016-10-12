//
//  ScrollviewDetailHeaderView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ScrollviewDetailHeaderView.h"
#import <UIImageView+WebCache.h>

#define TOP_MARGIN 20
#define LEFT_MARGIN 15
@interface ScrollviewDetailHeaderView ()<UITextFieldDelegate>
//数据
@property(nonatomic, strong)NSDictionary * headerDic;
@property(nonatomic, strong)NSArray<MaterialModel *> * materialArray;
//头图片
@property(nonatomic, strong)UIImageView * topImgView;
//题目
@property(nonatomic, strong)UILabel * titleLable;
//作者头像+名字
@property(nonatomic, strong)UIImageView * userPic;
@property(nonatomic, strong)UILabel * userNameLabel;
//浏览和收藏数
@property(nonatomic, strong)UILabel * favLabel;
@property(nonatomic, strong)UILabel * timeLabel;
//简介文字
@property(nonatomic, strong)UILabel * detailTextLabel;
@property(nonatomic, strong)UIButton * favourtButton;
//材料
@property(nonatomic, strong)UILabel * materialLabel;
@property(nonatomic, strong)UIView * quantityBgView;
//分量
@property(nonatomic, strong)UILabel * quantityLaebl;
//个
@property(nonatomic, strong)UILabel * geLabel;
//减的按钮
@property(nonatomic, strong)UIButton * subButton;
//加的按钮
@property(nonatomic, strong)UIButton * plusButton;
//数量文本框
@property(nonatomic, strong)UITextField * quantityField;
@property(nonatomic, assign)NSInteger numOfQuantity;
//材料名称  数量
@property(nonatomic, strong)UILabel * materialNameLabel;
@property(nonatomic, strong)UILabel * mateialNumLabel;
//做法
@property(nonatomic, strong)UILabel * makeWayLabel;

@end

@implementation ScrollviewDetailHeaderView

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForTopView];
    [self initFotDetailView];
    [self initForMateralView];
    [self initForMateriaDetailView];
    [self initForFooterView];
}

#pragma mark
#pragma mark =========== 设置头视图
-(void)initForTopView{
    _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/9*8)];
    _topImgView.userInteractionEnabled = YES;
    [_topImgView sd_setImageWithURL:[NSURL URLWithString:_headerDic[@"coverImage"]] placeholderImage:[UIImage imageNamed:@"gray_bg"]];
    [self addSubview:_topImgView];
    
    float titleHeight = [self labelHeight:[UIFont systemFontOfSize:20] text:_headerDic[@"title"] width:self.width-2*LEFT_MARGIN];
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_topImgView.frame)+TOP_MARGIN, self.width-2*LEFT_MARGIN, titleHeight)];
    _titleLable.font = [UIFont systemFontOfSize:20];
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = _headerDic[@"title"];
    _titleLable.numberOfLines = 0;
    [self addSubview:_titleLable];
    
    float userPicWidth = (self.width-2*LEFT_MARGIN)/5;
    _userPic = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_MARGIN+2*userPicWidth, CGRectGetMaxY(_titleLable.frame)+TOP_MARGIN, userPicWidth, userPicWidth)];
    _userPic.userInteractionEnabled = YES;
    _userPic.layer.cornerRadius = userPicWidth/2;
    _userPic.clipsToBounds = YES;
    [_userPic sd_setImageWithURL:[NSURL URLWithString:_headerDic[@"clientImage"]] placeholderImage:[UIImage imageNamed:@"gray_bg"]];
    [self addSubview:_userPic];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_userPic.frame)+LEFT_MARGIN, self.width-2*LEFT_MARGIN, 15)];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.font = [UIFont systemFontOfSize:12];
    _userNameLabel.text = _headerDic[@"clientName"];
    _userNameLabel.textColor = [UIColor grayColor];
    [self addSubview:_userNameLabel];
    
    _favLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_userNameLabel.frame)+5, self.width-2*LEFT_MARGIN, 10)];
    _favLabel.textAlignment = NSTextAlignmentCenter;
    _favLabel.textColor = [UIColor grayColor];
    _favLabel.font = [UIFont systemFontOfSize:10];
    _favLabel.text = [NSString stringWithFormat:@"%@次浏览 · %@人收藏", _headerDic[@"visitNum"], _headerDic[@"likeNum"]];
    [self addSubview:_favLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_favLabel.frame)+5, self.width-2*LEFT_MARGIN, 10)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.text = [NSString stringWithFormat:@"创建于%@", _headerDic[@"createTime"]];
    [self addSubview:_timeLabel];
}

#pragma mark
#pragma mark ============ 简介和收藏按钮
-(void)initFotDetailView{
    float detailHeight = [self labelHeight:[UIFont systemFontOfSize:13] text:_headerDic[@"coverSummary"] width:self.width-2*LEFT_MARGIN];
    _detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_timeLabel.frame)+10, self.width-2*LEFT_MARGIN, detailHeight)];
    _detailTextLabel.textAlignment = NSTextAlignmentCenter;
    _detailTextLabel.font = [UIFont systemFontOfSize:13];
    _detailTextLabel.textColor = [UIColor grayColor];
    
    NSString * str = _headerDic[@"coverSummary"];
    /*
     if (str != nil) {
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
     [paragraphStyle setLineSpacing:2];
     [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
     _detailTextLabel.attributedText = attributedString;
     }
     */
    _detailTextLabel.text = str;
    _detailTextLabel.numberOfLines = 0;
    [self addSubview:_detailTextLabel];
    
    float favButtonWidth = (self.width-2*LEFT_MARGIN)/2;
    _favourtButton = [[UIButton alloc] initWithFrame:CGRectMake(LEFT_MARGIN+favButtonWidth/2, CGRectGetMaxY(_detailTextLabel.frame)+TOP_MARGIN, favButtonWidth, 30)];
    [_favourtButton setTitle:@"收藏" forState:UIControlStateNormal];
    [_favourtButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [_favourtButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBgClick"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    _favourtButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_favourtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_favourtButton addTarget:self action:@selector(favourAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_favourtButton];
}
-(void)favourAction:(UIButton *)button{
#warning 收藏操作
}

#pragma mark
#pragma mark ========= 材料
-(void)initForMateralView{
    _numOfQuantity = [_headerDic[@"quantity"] integerValue];
    if (_numOfQuantity != 0) {
        _materialLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_favourtButton.frame)+LEFT_MARGIN, 40, 20)];
        _materialLabel.textAlignment = NSTextAlignmentLeft;
        _materialLabel.textColor = [UIColor blackColor];
        _materialLabel.text = @"材料";
        _materialLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_materialLabel];
        
        float quantityBgWidth = self.width/2;
        _quantityBgView = [[UIView alloc] initWithFrame:CGRectMake(quantityBgWidth/2, CGRectGetMaxY(_materialLabel.frame)+TOP_MARGIN, quantityBgWidth, 20)];
        [self addSubview:_quantityBgView];
        _quantityLaebl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        _quantityLaebl.text = @"分量";
        _quantityLaebl.textColor = [UIColor blackColor];
        _quantityLaebl.font = [UIFont systemFontOfSize:14];
        _quantityLaebl.textAlignment = NSTextAlignmentLeft;
        [self.quantityBgView addSubview:_quantityLaebl];
        _geLabel = [[UILabel alloc] initWithFrame:CGRectMake(_quantityBgView.width-30, 0, 30, 20)];
        _geLabel.text = _headerDic[@"unit"];
        _geLabel.textAlignment = NSTextAlignmentRight;
        _geLabel.font = [UIFont systemFontOfSize:14];
        _geLabel.textColor = [UIColor blackColor];
        [self.quantityBgView addSubview:_geLabel];
        
        float btnWidth = (_quantityBgView.width-60)/6;
        _subButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_quantityLaebl.frame)+btnWidth, 0, btnWidth, 20)];
        [_subButton setTitle:@"–" forState:UIControlStateNormal];
        [_subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_subButton setBackgroundColor:[UIColor grayColor]];
        [_subButton addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.quantityBgView addSubview:_subButton];
        
        _quantityField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_subButton.frame), 0, 2*btnWidth, 20)];
        _quantityField.textAlignment = NSTextAlignmentCenter;
        _quantityField.text = [NSString stringWithFormat:@"%ld", _numOfQuantity];
        _quantityField.textColor = [UIColor blackColor];
        _quantityField.font = [UIFont systemFontOfSize:14];
        _quantityField.delegate = self;
        [self.quantityBgView addSubview:_quantityField];
        
        _plusButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_quantityField.frame), 0, btnWidth, 20)];
        [_plusButton setTitle:@"+" forState:UIControlStateNormal];
        [_plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_plusButton setBackgroundColor:[UIColor grayColor]];
        [_plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.quantityBgView addSubview:_plusButton];
    }
}
-(void)subAction:(UIButton *)btn{
    if (_numOfQuantity > 0) {
        _numOfQuantity--;
        _quantityField.text = [NSString stringWithFormat:@"%ld", _numOfQuantity];
    }
}
-(void)plusAction:(UIButton *)btn{
    _numOfQuantity++;
    _quantityField.text = [NSString stringWithFormat:@"%ld", _numOfQuantity];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_quantityField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _numOfQuantity = [textField.text integerValue];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_quantityField resignFirstResponder];
}

#pragma mark
#pragma mark ========= 详细材料
-(void)initForMateriaDetailView{
    float materialWidth = (self.width-2*LEFT_MARGIN)/2;
    if (_materialArray.count > 1 && ![_materialArray[1].weight isEqualToString:@""]) {
        for (NSInteger i = 0; i < _materialArray.count; i++) {
            _materialNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_quantityBgView.frame)+TOP_MARGIN+(20+10)*i, materialWidth, 20)];
            _materialNameLabel.textColor = [UIColor blackColor];
            _materialNameLabel.textAlignment = NSTextAlignmentCenter;
            _materialNameLabel.font = [UIFont systemFontOfSize:14];
            _materialNameLabel.text = _materialArray[i].name;
            [self addSubview:_materialNameLabel];
            
            _mateialNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN+materialWidth, CGRectGetMaxY(_quantityBgView.frame)+TOP_MARGIN+(20+10)*i, materialWidth, 20)];
            _mateialNumLabel.textAlignment = NSTextAlignmentCenter;
            _mateialNumLabel.textColor = [UIColor blackColor];
            _mateialNumLabel.font = [UIFont systemFontOfSize:14];
            _mateialNumLabel.text = _materialArray[i].weight;
            [self addSubview:_mateialNumLabel];
        }
    }else{
        NSMutableString * str = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < _materialArray.count; i++) {
            [str appendFormat:@"%@ ", _materialArray[i].name];
        }
        float materHeight = [self labelHeight:[UIFont systemFontOfSize:14] text:str width:self.width-2*LEFT_MARGIN];
        _materialNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_quantityBgView.frame)+TOP_MARGIN, self.width-2*LEFT_MARGIN, materHeight)];
        _materialNameLabel.textColor = [UIColor blackColor];
        _materialNameLabel.textAlignment = NSTextAlignmentLeft;
        _materialNameLabel.font = [UIFont systemFontOfSize:14];
        _materialNameLabel.text = str;
        _materialNameLabel.numberOfLines = 0;
        [self addSubview:_materialNameLabel];
    }
}

#pragma mark
#pragma mark ============= 设置底下的内容
-(void)initForFooterView{
    _makeWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_materialNameLabel.frame)+LEFT_MARGIN, self.width-2*LEFT_MARGIN, 15)];
    _makeWayLabel.textAlignment = NSTextAlignmentLeft;
    _makeWayLabel.textColor = [UIColor blackColor];
    _makeWayLabel.font = [UIFont systemFontOfSize:15];
    _makeWayLabel.text = @"做法";
    [self addSubview:_makeWayLabel];
}

//设置数据
-(void)setHeaderViewStyle:(NSDictionary *)dic maters:(NSArray<MaterialModel *> *)maters{
    _headerDic = dic;
    _materialArray = maters;
}

#pragma mark
#pragma mark =========== 工具类
-(CGFloat)labelHeight:(UIFont *)font text:(NSString *)text width:(float)width{
    CGSize mySize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

@end
