//
//  TuanShopTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/27.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TuanShopTableViewCell.h"
#import <UIImageView+WebCache.h>

#define PIC_WIDTH self.width-20
#define MARGIN 10
@interface TuanShopTableViewCell ()

@property(nonatomic, strong)NSDictionary * myDic;
//主要的大图片
@property(nonatomic, strong)UIImageView * picView;
@property(nonatomic, strong)UIImageView * sucessPic;
//产品名称
@property(nonatomic, strong)UILabel * productName;
@property(nonatomic, strong)UIView * lineView;
//拼团情况
@property(nonatomic, strong)UILabel * tuanNumLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * shopLabel;
@property(nonatomic, strong)UIView * bottomLineView;

@end

@implementation TuanShopTableViewCell

-(void)setCellStyle:(NSDictionary *)dic{
    _myDic = dic;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForPicView];
    [self initForPriceView];
    [self initForTuanTitleView];
    [self initForTuanView];
}

#pragma mark
#pragma mark ======== 创建展示的图片/拼团成功图片
-(void)initForPicView{
    _picView = [[UIImageView alloc] init];
    float height = PIC_WIDTH;
    _picView.frame = CGRectMake(MARGIN, MARGIN, PIC_WIDTH, height/9*5);
    [_picView sd_setImageWithURL:[NSURL URLWithString:_myDic[@"coverImage"] ] placeholderImage:[UIImage imageNamed:@"china"]];
    [self addSubview:_picView];
    
    if ([_myDic[@"isSuccess"] isEqual:@(1)]) {
        float width = 50;
        _sucessPic = [[UIImageView alloc] init];
        _sucessPic.frame = CGRectMake(_picView.width-width, _picView.height-width, width, width);
        _sucessPic.image = [UIImage imageNamed:@"tuanSuccess"];
        [self.picView addSubview:_sucessPic];
    }
}
#pragma mark
#pragma mark ======== 图片上的价格和标签
-(void)initForPriceView{
    
}

#pragma mark
#pragma mark ========= 标题和标题下面的线
-(void)initForTuanTitleView{
    _productName = [[UILabel alloc] init];
    _productName.frame = CGRectMake(MARGIN, CGRectGetMaxY(_picView.frame)+MARGIN, PIC_WIDTH, MARGIN);
    _productName.font = [UIFont systemFontOfSize:14];
    _productName.textAlignment = NSTextAlignmentLeft;
    _productName.textColor = [UIColor blackColor];
    _productName.text = _myDic[@"coverTitle"];
    [self addSubview:_productName];
    
    _lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(MARGIN, CGRectGetMaxY(_productName.frame)+MARGIN-1, PIC_WIDTH, 1);
    _lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineView];
}

#pragma mark
#pragma mark ========= 拼团的情况
-(void)initForTuanView{
    float width = self.width/4;
    _tuanNumLabel = [[UILabel alloc] init];
    _tuanNumLabel.frame = CGRectMake(MARGIN, CGRectGetMaxY(_lineView.frame)+MARGIN, width, 20);
    _tuanNumLabel.font = [UIFont systemFontOfSize:12];
    _tuanNumLabel.textAlignment = NSTextAlignmentLeft;
    NSString * num = [NSString stringWithFormat:@"%@", _myDic[@"groupNum"]];
    NSString * productStr = [NSString stringWithFormat:@"已有%@人拼团", num];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:productStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, num.length)];
    _tuanNumLabel.attributedText = attrStr;
    [self addSubview:_tuanNumLabel];
    
//    右边两个label，要与当前时间得出
    
    
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.frame = CGRectMake(0, self.height-MARGIN, self.width, MARGIN);
    _bottomLineView.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00];
    [self addSubview:_bottomLineView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
