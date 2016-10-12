//
//  PinView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "PinView.h"
#import <UIImageView+WebCache.h>

#define LEFT_MARGIN 15
#define TOP_MARGIN 10

@interface PinView ()

@property(nonatomic, copy)NSString * picStr;
@property(nonatomic, copy)NSString * titleStr;
@property(nonatomic, copy)NSString * nowPrice;
@property(nonatomic, copy)NSString * originPrice;

@property(nonatomic, strong)UIImageView * picView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * nowPriceLabel;
@property(nonatomic, strong)UILabel * originPriceLabel;

@end

@implementation PinView

-(void)setValueForHeader:(NSString *)picStr title:(NSString *)title nowPrice:(NSString *)nowPrice originPrice:(NSString *)originPrice{
    _picStr = picStr;
    _titleStr = title;
    _nowPrice = nowPrice;
    _originPrice = originPrice;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForView];
}

#pragma mark
#pragma mark =========== 创建view
-(void)initForView{
    _picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/9*6)];
    [_picView sd_setImageWithURL:[NSURL URLWithString:_picStr] placeholderImage:[UIImage imageNamed:@"china"]];
    [self addSubview:_picView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_picView.frame)+TOP_MARGIN, self.width-2*LEFT_MARGIN, 15)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
    _titleLabel.text = _titleStr;
    [self addSubview:_titleLabel];
    
    _nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_titleLabel.frame)+TOP_MARGIN, self.width-2*LEFT_MARGIN, 10)];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"团购价 : ￥%@", _nowPrice]];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, _nowPrice.length+1)];
    [_nowPriceLabel setAttributedText:attStr];
    _nowPriceLabel.textAlignment = NSTextAlignmentLeft;
    _nowPriceLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_nowPriceLabel];
    
    _originPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_nowPriceLabel.frame)+TOP_MARGIN, self.width-2*LEFT_MARGIN, 10)];
    NSMutableAttributedString * attStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"淘宝价 : ￥%@", _originPrice]];
    [attStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, _originPrice.length+1)];
    [_originPriceLabel setAttributedText:attStr2];
    _originPriceLabel.textAlignment = NSTextAlignmentLeft;
    _originPriceLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_originPriceLabel];
}
@end
