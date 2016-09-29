//
//  QuestionTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "QuestionTableViewCell.h"
#import <UIImageView+WebCache.h>

#define MARGIN 10
#define LEFT_WIDTH 40
#define MAIN_WIDTH self.width-70
#define LITTLE_MARGIN 5
#define USER_PIC_WIDTH 20

@interface QuestionTableViewCell ()

@property(nonatomic, strong)QuestionModel * quesModel;
//左边
@property(nonatomic, strong)UIView * leftBgView;
@property(nonatomic, strong)UILabel * numLabel;
@property(nonatomic, strong)UILabel * strLabel;
//中间
@property(nonatomic, strong)UILabel * userNameLabel;
@property(nonatomic, strong)UILabel * honerLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * mainQuesLabel;
//右边头像
@property(nonatomic, strong)UIImageView * userPic;
@property(nonatomic, strong)UIView * lineView;

@end

@implementation QuestionTableViewCell

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForLeftView];
    [self initForMainView];
    [self initForRightView];
}

-(void)setCellModel:(QuestionModel *)model{
    _quesModel = model;
}
#pragma mark
#pragma mark ========== 左边回答数
-(void)initForLeftView{
    _leftBgView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, LEFT_WIDTH, LEFT_WIDTH)];
    if (_quesModel.answerNum > 0) {
        _leftBgView.backgroundColor = [UIColor greenColor];
    }else{
        _leftBgView.backgroundColor = [UIColor redColor];
    }
    _leftBgView.layer.cornerRadius = 5;
    _leftBgView.clipsToBounds = YES;
    [self addSubview:_leftBgView];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LEFT_WIDTH, LEFT_WIDTH/3*2)];
    _numLabel.adjustsFontSizeToFitWidth = YES;
    _numLabel.font = [UIFont systemFontOfSize:18];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.text = @(_quesModel.answerNum).stringValue;
    [_leftBgView addSubview:_numLabel];
    
    _strLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, LEFT_WIDTH/3*2-3, LEFT_WIDTH, LEFT_WIDTH/3)];
    _strLabel.font = [UIFont systemFontOfSize:12];
    _strLabel.textAlignment = NSTextAlignmentCenter;
    _strLabel.textColor = [UIColor whiteColor];
    _strLabel.text = @"回答";
    [_leftBgView addSubview:_strLabel];
}
#pragma mark
#pragma mark ========== 中间的问题和内容
-(void)initForMainView{
    float userNameWidth = [self labelWidth:_quesModel.clientName];
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*MARGIN+LEFT_WIDTH, MARGIN+LITTLE_MARGIN, userNameWidth, 10)];
    _userNameLabel.font = [UIFont systemFontOfSize:12];
    _userNameLabel.textColor = [UIColor redColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.text = _quesModel.clientName;
    [self addSubview:_userNameLabel];
    
    NSString * hornerStr = [NSString stringWithFormat:@"%ld声望", _quesModel.popularity];
    float hornerWidth = [self labelWidth:hornerStr];
    _honerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userNameLabel.frame)+LITTLE_MARGIN, MARGIN+LITTLE_MARGIN, hornerWidth, 10)];
    _honerLabel.textColor = [UIColor grayColor];
    _honerLabel.textAlignment = NSTextAlignmentLeft;
    _honerLabel.font = [UIFont systemFontOfSize:12];
    _honerLabel.text = hornerStr;
    [self addSubview:_honerLabel];
    
#warning 时间的还没算，等封装之后，写入PCH
    _timeLabel = [[UILabel alloc] init];
    [self addSubview:_timeLabel];
    
    float mainTextHeigh = [self labelHeight];
    if (mainTextHeigh > 34) {
        mainTextHeigh = 34;
    }
    _mainQuesLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*MARGIN+LEFT_WIDTH, CGRectGetMaxY(_userNameLabel.frame)+LITTLE_MARGIN, MAIN_WIDTH, mainTextHeigh)];
    _mainQuesLabel.textAlignment = NSTextAlignmentLeft;
    _mainQuesLabel.textColor = [UIColor blackColor];
    _mainQuesLabel.font = [UIFont systemFontOfSize:14];
    _mainQuesLabel.text = _quesModel.coverTitle;
    _mainQuesLabel.numberOfLines = 2;
    [self addSubview:_mainQuesLabel];
}
#pragma mark
#pragma mark ========== 右边的头像
-(void)initForRightView{
    _userPic = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-MARGIN-USER_PIC_WIDTH, MARGIN, USER_PIC_WIDTH, USER_PIC_WIDTH)];
    [_userPic sd_setImageWithURL:[NSURL URLWithString:_quesModel.clientImage]];
    _userPic.userInteractionEnabled = YES;
    _userPic.layer.cornerRadius = USER_PIC_WIDTH/2;
    _userPic.clipsToBounds = YES;
    [self addSubview:_userPic];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    [self addSubview:_lineView];
}

#pragma mark
#pragma mark ============ 工具类
-(CGFloat)labelHeight{
    CGSize mySize = CGSizeMake(MAIN_WIDTH, CGFLOAT_MAX);
    CGSize size = [_quesModel.coverTitle boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}
-(CGFloat)labelWidth:(NSString *)text{
    CGSize mySize = CGSizeMake(CGFLOAT_MAX, 10);
    CGSize size = [text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    return size.width;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
