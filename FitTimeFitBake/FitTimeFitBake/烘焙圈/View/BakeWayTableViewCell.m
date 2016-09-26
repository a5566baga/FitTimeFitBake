//
//  BakeWayTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BakeWayTableViewCell.h"
#import <UIImage+GIF.h>
#import <UIImageView+WebCache.h>
#import "MyZanButton.h"

#define leftMargin 15
#define topMargin 10
#define margin 10
#define mainWidth self.width-70

@interface BakeWayTableViewCell ()

@property(nonatomic, strong)BakeWayModel * bakeWayModel;
//用户头像
@property(nonatomic, strong)UIImageView * userPic;
//@property(nonatomic, strong)UIImageView * userLevelPic;
//@property(nonatomic, strong)UILabel * userLevelLabel;
//用户名和作品信息
@property(nonatomic, strong)UILabel * userNameLabel;
@property(nonatomic, strong)UILabel * userTitleLabel;
@property(nonatomic, strong)UIImageView * logoImage;
@property(nonatomic, strong)UILabel * desprseLabel;
//图片展示
@property(nonatomic, strong)UIImageView * showPicView;
//点赞区域
@property(nonatomic, strong)UIView * zanBgView;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)MyZanButton * glodButton;
@property(nonatomic, strong)MyZanButton * zanButton;
@property(nonatomic, strong)MyZanButton * commentButton;
//评论区
@property(nonatomic, strong)UIImageView * commentBgView;
@property(nonatomic, strong)UILabel * commentDetailLabel;

@end

@implementation BakeWayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForUserPic];
    [self initForTitleView];
    [self initForDetailPicView];
    [self initForZanView];
    [self initForCommentView];
}

-(void)setCellStyle:(BakeWayModel *)model{
    _bakeWayModel = model;
}

#pragma mark
#pragma mark ============ 创建用户头像
-(void)initForUserPic{
    float userPicWidth = 40;
    _userPic = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, topMargin, userPicWidth, userPicWidth)];
    _userPic.userInteractionEnabled = YES;
    _userPic.layer.cornerRadius = userPicWidth/2;
    _userPic.layer.masksToBounds = YES;
    [_userPic sd_setImageWithURL:[NSURL URLWithString:_bakeWayModel.clientImage]];
    [self addSubview:_userPic];
}
#pragma mark
#pragma mark ============ 创建用户作品题目名信息
-(void)initForTitleView{
    float leftLabelMargin = leftMargin+CGRectGetWidth(_userPic.frame)+margin;
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.frame = CGRectMake(leftLabelMargin, topMargin, self.width-leftLabelMargin, 20);
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_userNameLabel];
    _userNameLabel.text = _bakeWayModel.clientName;
    
    _userTitleLabel = [[UILabel alloc] init];
    _userTitleLabel.frame = CGRectMake(leftLabelMargin, CGRectGetMaxY(_userNameLabel.frame), self.width-leftLabelMargin, 10);
    _userTitleLabel.font = [UIFont systemFontOfSize:12];
    _userTitleLabel.textColor = [UIColor grayColor];
    _userTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_userTitleLabel];
    _userTitleLabel.text = _bakeWayModel.title;
    
    float logoLeftMargin = leftLabelMargin+5+[self labelWidth];
    _logoImage = [[UIImageView alloc] init];
    _logoImage.frame = CGRectMake(logoLeftMargin, CGRectGetMaxY(_userNameLabel.frame), 30, 15);
    _logoImage.userInteractionEnabled = YES;
    if (_bakeWayModel.type == 4) {
        UIImage * gifImg = [UIImage sd_animatedGIFNamed:@"zuopin"];
        _logoImage.image = gifImg;
    }else if(_bakeWayModel.type == 2){
        UIImage * gifImg = [UIImage sd_animatedGIFNamed:@"shipu"];
        _logoImage.image = gifImg;
    }
    [self addSubview:_logoImage];
    
    float desHeight = [self labelHeight];
    if (desHeight > 34) {
        desHeight = 34;
    }
    _desprseLabel = [[UILabel alloc] init];
    _desprseLabel.frame = CGRectMake(leftLabelMargin, CGRectGetMaxY(_logoImage.frame), mainWidth, desHeight);
    _desprseLabel.font = [UIFont systemFontOfSize:14];
    _desprseLabel.textColor = [UIColor blackColor];
    _desprseLabel.textAlignment = NSTextAlignmentLeft;
    _desprseLabel.text = _bakeWayModel.introduce;
    _desprseLabel.numberOfLines = 2;
    [self addSubview:_desprseLabel];
}

#pragma mark
#pragma mark ============== 图片展示
-(void)initForDetailPicView{
    NSArray * picArray = _bakeWayModel.image;
    float detailPicWidth = (mainWidth-2*3-30)/3;
    for (NSInteger i = 0; i < picArray.count; i++) {
#warning 没有添加点击事件
        _showPicView = [[UIImageView alloc] init];
        if (picArray.count == 1) {
            detailPicWidth = 2*(detailPicWidth+3);
        }
        _showPicView.frame = CGRectMake(leftMargin+40+margin+(detailPicWidth+3)*(i%3), CGRectGetMaxY(_desprseLabel.frame)+margin+(detailPicWidth+3)*(i/3), detailPicWidth, detailPicWidth);
        _showPicView.userInteractionEnabled = YES;
        [_showPicView sd_setImageWithURL:[NSURL URLWithString:picArray[i]] placeholderImage:[UIImage imageNamed:@"noImage"]];
        [self addSubview:_showPicView];
    }
}

#pragma mark
#pragma mark ============== 点赞区
-(void)initForZanView{
    float zanHeight = 20;
    float zanWidth = 20;
    float zanBtnWidth = 40;
    _zanBgView = [[UIView alloc] init];
    _zanBgView.frame = CGRectMake(leftMargin+40+margin, CGRectGetMaxY(_showPicView.frame)+5, mainWidth, zanHeight);
    _zanBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_zanBgView];
    
#warning 处理时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(0, 0, zanWidth*3, zanHeight);
    _timeLabel.backgroundColor = [UIColor blueColor];
    [self.zanBgView addSubview:_timeLabel];
    
#pragma mark
#pragma mark ============ 以下均没有添加事件
    float zanLeftMargin = self.zanBgView.width-3*zanBtnWidth-margin;
    _glodButton = [[MyZanButton alloc] init];
    _glodButton.frame = CGRectMake(zanLeftMargin, 0, zanBtnWidth, zanHeight);
    [_glodButton setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
    [_glodButton setTitle:@(_bakeWayModel.rewardNum).stringValue forState:UIControlStateNormal];
    [_glodButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.zanBgView addSubview:_glodButton];
    
    _zanButton = [[MyZanButton alloc] init];
    _zanButton.frame = CGRectMake(zanLeftMargin+zanBtnWidth, 0, zanBtnWidth, zanHeight);
    [_zanButton setImage:[UIImage imageNamed:@"ding"] forState:UIControlStateNormal];
    [_zanButton setTitle:@(_bakeWayModel.likeNum).stringValue forState:UIControlStateNormal];
    [_zanButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.zanBgView addSubview:_zanButton];
    
    _commentButton = [[MyZanButton alloc] init];
    _commentButton.frame = CGRectMake(zanLeftMargin+2*zanBtnWidth, 0, zanBtnWidth, zanHeight);
    [_commentButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [_commentButton setTitle:@(_bakeWayModel.commentNum).stringValue forState:UIControlStateNormal];
    [_commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.zanBgView addSubview:_commentButton];
}

#pragma mark
#pragma mark =============== 评论区
-(void)initForCommentView{
    _commentBgView = [[UIImageView alloc] init];
    _commentBgView.frame = CGRectMake(leftMargin+40+margin, CGRectGetMaxY(_zanBgView.frame)+5, mainWidth, 100);
    _commentBgView.userInteractionEnabled = YES;
    [self addSubview:_commentBgView];
    
    float allHeight = 0;
}

#pragma mark
#pragma mark ============== 计算文字宽度的
-(CGFloat)labelWidth{
    CGSize mySize = CGSizeMake(CGFLOAT_MAX, 10);
    CGSize size = [_bakeWayModel.title boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    return size.width;
}
#pragma mark
#pragma mark =============== 计算文字高度的
-(CGFloat)labelHeight{
    CGSize mySize = CGSizeMake(mainWidth, CGFLOAT_MAX);
    CGSize size = [_bakeWayModel.introduce boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
