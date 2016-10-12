//
//  PinTuanTableViewCell.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "PinTuanTableViewCell.h"

@interface PinTuanTableViewCell ()<UIWebViewDelegate, UIScrollViewDelegate>

@property(nonatomic, copy)NSString * htmlStr;
@property(nonatomic, strong)UIView * leftRedView;
@property(nonatomic, strong)UILabel * detailLabel;
@property(nonatomic, strong)UIWebView * webView;

@end

@implementation PinTuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellValue:(NSString *)htmlStr{
    _htmlStr = htmlStr;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    [self initForCellView];
}

#pragma mark
#pragma mark ============= 创建cell视图
-(void)initForCellView{
    _leftRedView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 3, 15)];
    _leftRedView.backgroundColor = [UIColor redColor];
    [self addSubview:_leftRedView];
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 15)];
    _detailLabel.text = @"图文详情";
    _detailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_detailLabel];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame)+10, self.width, self.height-CGRectGetMaxY(_detailLabel.frame))];
    _webView.scalesPageToFit = YES;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    [_webView loadHTMLString:_htmlStr baseURL:nil];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [self addSubview:_webView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y == 0) {
        self.scrollToTop();
    }else{
        self.scrollToDown();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
